module Api
  module V1
    class PropertiesController < ApplicationController
      respond_to :json
      before_action :set_property,except: [:index,:order]
      before_action :detect_device, only: [:index]

      def index
        params[:active] = 'true'

        if params[:offer_price].present?
          offer_price = params[:offer_price]
          params.delete :offer_price
        end

        q = QueryTools.query params
        pagination_by_device

        @properties = Property.where(q)
        .page(params[:page])
        .per(@per_page)
        .order_by_status

        filter_by_offer_price(offer_price) if offer_price.present?
        @properties = @properties.order(offer_price: params[:order]) if params[:order].present?

        respond_with @properties,
        meta: {
          current_page: @properties.current_page,
          next_page: @properties.next_page,
          prev_page: @properties.prev_page,
          total_pages: @properties.total_pages,
          total_count: @properties.total_count,
          limit: (params[:limit] || 100).to_i
        }
      end

      def pagination_by_device
        if @browser.device.tablet?
          per_page = Settings.pagination.properties.per_page.tablet
        elsif @browser.device.mobile?
          per_page = Settings.pagination.properties.per_page.mobile
        else
          per_page = Settings.pagination.properties.per_page.default
        end
        @per_page = per_page
      end

      def filter_by_offer_price(offer_price)
        offer_price = offer_price.split(',')
        min_price = offer_price.first.to_i
        max_price = offer_price.last.to_i 
        offer_price = Range.new(min_price, max_price)
        @properties = @properties.where(offer_price: min_price..max_price)
      end

      def show
        respond_with @property
      end

      def order
        properties = params.require(:properties)
        order = {}
        properties.each_with_index do |id,i|
          order.merge! id => {featured: i+1}
        end

        if Property.update(order.keys,order.values)
          render json: nil,status: :ok
        else
          render json: nil,status: :unprocessable_entity
        end
      end

      private

      def set_property
        @property = Property.friendly.find(params[:id])
      end

      def detect_device
        user_agent = request.user_agent
        @browser = Browser.new(user_agent, accept_language: "en-us")
      end
    end
  end
end