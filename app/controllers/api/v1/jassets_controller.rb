module Api
  module V1
    class JassetsController < ApplicationController
      before_action :authorize, except: [:index]
      before_action :set_jasset,only: [:show,:edit,:destroy,:update]
      respond_to :json

      def index
        order_link_name = params[:order_link_name] if params[:order_link_name].present?
        params.delete :order_link_name

        q = QueryTools.query params

        @jassets = Jasset.where(q)
        .page(params[:page])
        .per((params[:limit] || 100).to_i)
        .order(params[:order])

        @jassets = @jassets.order(link_name: order_link_name) if order_link_name.present?

        respond_with @jassets,
        meta: {
          current_page: @jassets.current_page,
          next_page: @jassets.next_page,
          prev_page: @jassets.prev_page,
          total_pages: @jassets.total_pages,
          total_count: @jassets.total_count,
          limit: (params[:limit] || 100).to_i
        }
      end

      def create
        @jasset = Jjasset.new p
        if @jasset.save
          render json: @jasset,status: 201
        else
          render json: {errors: @jasset.errors},status: 422
        end
      end

      def update
        @jasset.remove_image! if params[:jasset][:remove_image] == true
        if @jasset.update(p)
          render json: @jasset,status: 201
        else
          render json: {errors: @jasset.errors},status: 422
        end
      end

      def destroy
        @jasset.destroy
        render json: nil,status: 200
      end

      private

      def set_jasset
        @jasset = Jasset.find params[:id]
      end

      def p
        params.require(:jasset).permit :title,:description,:link_name,:link_uri
      end
    end
  end
end