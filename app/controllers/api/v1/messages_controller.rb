class Api::V1::MessagesController < ApplicationController

    before_action :set_application, :set_chat

    def index
        unless @application.nil?
            messages = @chat.messages.order("updated_at DESC")
            render json: {STATUS: "SUCCESS", messages: messages }, status: :ok
        else
            render json: {STATUS: "ERROR", error: "chat not found"}, status: :not_found
        end
    end
    
 # TODO: check token existed in redis before get the counter
    def create
        unless @application.nil?
            app_key = @application.app_key
            chat_number = @chat.number
            message_number = REDIS.HGET(app_key, chat_number).to_i + 1
            MessageCreationWorker.perform_async(app_key, chat_number, params[:body], message_number)
            REDIS.HINCRBY(app_key, chat_number, 1)
            render json: {number: message_number, body: params[:body] }
        else
            render json: {status: 'ERROR', message:'App not found', error: @application}, status: :not_found
        end
    end

    private

    def message_params
        params.require(:body)
    end

    def set_application
        @application = Application.find_by_app_key!(params[:app_key])
    end

    def set_chat
        @chat = @application.chats.find_by_number!(params[:chat_number])
    end
end
