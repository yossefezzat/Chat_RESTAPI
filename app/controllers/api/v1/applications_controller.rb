class Api::V1::ApplicationsController < ApplicationController
    
    def index
        apps = Application.paginate(:page => params[:page], :per_page => 10)
        render json: {status:'SUCCESS', data: apps}, status: :ok
    end

    def show
        app = Application.where("app_key" => params[:app_key]).first
        if app
            render json: {status: 'SUCCESS', data: app}, status: :ok
        else
            render json: {status: 'ERROR', message:'App not found', data: app}, status: :not_found
        end
    end

    def create
        app = Application.new(application_params)
        if app.save
            REDIS.HSET(app.app_key, "chats", 0)
            render json: {status: 'SUCCESS', message:'App created', data: app}, status: :created
        else
            render json: {status: 'ERROR', message:'App not saved', data: app.errors}, status: :unprocessable_entity
        end
    end

    def update
        app = Application.find_by_app_key(params[:app_key])
        unless app.nil?
            app.update(application_params)
            render json: app
        else
            render json: {status: "ERROR", error: "App not found"}, status: :not_found
        end
      end

    private

    def application_params
        params.permit(:name)
    end
end
