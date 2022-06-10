class Api::V1::SearchController < ApplicationController

    def searched
        puts params[:app_token]
        unless params[:query].blank?
            results = Message.search(params[:query]).records.where({app_key: params[:app_key], chat_id: params[:chat_number]})
            render json: results
        else
            render json: {STATUS: "ERROR"}
        end
    end
end
