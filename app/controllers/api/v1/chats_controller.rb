class Api::V1::ChatsController < ApplicationController
# TODO: order chats by lastmessage : later
    before_action :set_mutex

    def index
        app = Application.find_by_app_key(params[:app_key])   # TODO sort by last message
        unless app.nil?
            chats = app.chats.all
            render json: {data: chats}
        else
            render json: {status: "ERROR", error: "App not found"}, status: :not_found
        end 
    end

    def show
        app = Application.find_by_app_key(params[:app_key])
        unless app.nil?
            chat = app.chats.find_by(number: params[:chat_number])
            if chat
                render json: chat
            else
                render json: {status: 'ERROR', error:'Chat not found'}, status: :not_found
            end
        else
            render json: {status: 'ERROR', error: 'App not found'}, status: :not_found
        end
    end
    
    def create
        app_key = params[:app_key]
        app = Application.find_by_app_key(app_key)
        @mutex.synchronize do
            if app
                chat_count = REDIS.HGET(app_key, "chats")
                chat_count = chat_count.to_i+1
                ChatCreationWorker.perform_async(app_key, chat_count)
                REDIS.HINCRBY(app_key, "chats", 1)
                render json: {status:"SUCCESS", chat_number: chat_count}, status: :created
            else
                render json: {status: "ERROR", error: "App not found"}, status: :not_found
            end
        end
    end

    private

    def set_mutex
        @mutex = Mutex.new
    end
end
