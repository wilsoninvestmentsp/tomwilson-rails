module Api
  module V1
  	class PropertiesController < ApplicationController

  		respond_to :json

  		before_action :set_property,except: [:index,:order]

  		# GET
  		# :-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:
  		# :-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:
  		def index

        params[:active] = 'true'
  			q = QueryTools.query params

  			@properties = Property.where(q)
  			.page(params[:page])
  			.per((params[:limit] || 100).to_i)
        .order("FIELD(status, 'for_sale','coming_soon','reserved','sale_pending','sold','not_active'), CASE WHEN status = 'for_sale' THEN RAND() ELSE 1 END")

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
  		# :-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:
  		# :-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:


  		# SHOW
  		# :-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:
  		# :-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:
  		def show

  			respond_with @property

  		end
  		# :-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:
  		# :-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:


      # ORDER
      # :-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:
      # :-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:
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
      # :-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:
      # :-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:


  		private
      # :-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:
      # :-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:
  		def set_property
  		  @property = Property.friendly.find(params[:id])
  		end
      # :-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:
      # :-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:

  	end
  end
end