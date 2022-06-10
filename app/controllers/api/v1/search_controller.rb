class Api::V1::SearchController < ApplicationController

    def searched
        unless params[:query].blank?
            results = Message.search(params[:query]).records.where({chat_id: params[:chat_number]})
            render json: results
        else
            render json: {error: "ERROR"}
        end
    end
end
