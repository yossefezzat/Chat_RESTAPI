class Api::V1::MessagesController < ApplicationController


    def index  # TODO: enhance it later 
        app_key = params[:app_key]
        chat_number = params[:chat_number]
        check_chat = REDIS.hexists(app_key, chat_number)
        if check_chat
            messages = Message.where('app_key' => app_key, 'chat_id'=> chat_number)
            render json: messages
        else
            render json: {status: 'ERROR', error: "Not found"}, status: :not_found
        end
        # app = Application.find_by_app_key(app_key)
        # unless app.nil?
        #     chat = Chat.find_by({application_id: app.id, number: chat_number})
        #     unless chat.nil?
        #         render json: {STATUS: "SUCCESS", messages: chat.messages }, status: :ok
        #     else
        #         render json: {STATUS: "ERROR", error: "Chat not found"}, status: :not_found
        #     end
        # else
        #     render json: {STATUS: "ERROR", error: "App not found"}, status: :not_found
        # end
    end
    

    def create
        app_key = params[:app_key]
        chat_number = params[:chat_number] 
        app = Application.find_by_app_key(app_key)
        unless app.nil?
            check_chat = REDIS.hexists(app_key, chat_number)
            if check_chat
                message_number = REDIS.HGET(app_key, chat_number).to_i + 1
                # add app key in message creation reference to elasticsearch to be filtered 
                MessageCreationWorker.perform_async(app_key, chat_number, params[:body], message_number) 
                REDIS.HINCRBY(app_key, chat_number, 1)
                render json: {number: message_number, body: params[:body] }
            else
                render json: {status: 'ERROR', error:'Chat not found'}, status: :not_found
            end
        else
            render json: {status: 'ERROR', error:'App not found'}, status: :not_found
        end
    end

    private

    def message_params
        params.require(:body)
    end
end
