module Api
  module V1
    class ChartsController < ApplicationController
      respond_to :json

      def create
        @chart = Chart.new params.require(:chart).permit :title,:value,:property_id
        if @chart.save
          render json: @chart,status: 201
        else
          render json: {errors: @chart.errors},status: 422
        end
      end

      def destroy
        Chart.find(params[:id]).destroy
        render json: nil,status: 200
      end
    end
  end
end