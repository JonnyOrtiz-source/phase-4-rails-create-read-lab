class PlantsController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity

    def index
        plants = Plant.all
        render json: plants, status: :ok
    end
    
    def show
        plant = Plant.find_by(id: params[:id])
        render json: plant, status: :ok
    end

    def create
        plant = Plant.create!(plant_params)
        render json: plant, status: :created
    end

    private

    def plant_params
        params.permit(:name, :image, :price)
    end

    def render_unprocessable_entity(invalid)
        render json: {errors: invalid.record.errors}, status: :unprocessable_entity
    end
end
