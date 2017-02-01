module Api
  module V1
    class LinksController < ApplicationController
      respond_to :json

      def create
        @link = Link.new params.require(:link).permit :title,:link,:property_id
        if @link.save
          render json: @link,status: 201
        else
          render json: {errors: @link.errors},status: 422
        end
      end

      def update
        @link = Link.find params[:id]
        if @link.update params.require(:link).permit :title,:link,:property_id
          render json: @link,status: 200
        else
          render json: {errors: @link.errors},status: 422
        end
      end

      def destroy
        @link = Link.find params[:id]
        @link.destroy
        render json: nil,status: 200
      end
    end
  end
end