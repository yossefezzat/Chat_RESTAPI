class Api::V1::ChatsController < ApplicationController

    before_action :set_application

    def index
        chats = @application.chats.all   # TODO sort by last message
        render json: {data: chats}
    end

    def show
        if @application
            @chat = @application.chats.find_by!(number: params[:chat_number])
            if @chat
                render json: {chat: @chat}
            else
                render json: {status: 'ERROR', message:'Chat not found', data: @chat}, status: :not_found
            end
            
        else
            render json: {status: 'ERROR', message:'App not found', data: @application}, status: :not_found
        end
    end
    
 # TODO: check token existed in redis before get the counter
    def create
        if @application
            app_key = @application.app_key
            chat_count = REDIS.HGET(app_key, "chats") # get chat count to add new one by updated count { without query mysql}
            chat_count = chat_count.to_i+1
            ChatCreationWorker.perform_async(app_key, chat_count)
            REDIS.HINCRBY(app_key, "chats", 1)   # increment cached chat count by 1 to create new chat
            render json: {chat_number: chat_count}
        else
            render json: {status: 'ERROR', message:'App not found', error: @application.error}, status: :not_found
        end
    end

    private

    # def chat_params
    #     params.permit(:number)
    # end

    def set_application
        @application = Application.find_by_app_key!(params[:app_key])
    end

end
