module Api
	module V1
		class JassetsController < ApplicationController
			
			before_action :authorize, except: [:index]
			before_action :set_jasset,only: [:show,:edit,:destroy,:update]

			respond_to :json

			# Begin index :-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:
			def index
				order_date = params[:order_date] if params[:order_date].present?
				params.delete :order_date
				params.delete :link_name if params[:link_name].blank?

				q = QueryTools.query params

				@jassets = Jasset.where(q)
				.page(params[:page])
				.per((params[:limit] || 100).to_i)
				.order(params[:order])

				@jassets = @jassets.order(link_name: :asc) if params[:link_name].present? && !order_date.present?
				@jassets = @jassets.order(created_at: order_date) if order_date.present?

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
			# End index :-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:


			# Begin create :-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:
			def create

				@jasset = Jjasset.new p

				if @jasset.save

					render json: @jasset,status: 201

				else

					render json: {errors: @jasset.errors},status: 422

				end

			end
			# End create :-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:


			# Begin update :-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:
			def update
				
				@jasset.remove_image! if params[:jasset][:remove_image] == true

				if @jasset.update(p)

					render json: @jasset,status: 201

				else

					render json: {errors: @jasset.errors},status: 422

				end

			end
			# End update :-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:


			# Begin destroy :-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:
			def destroy

				@jasset.destroy
				render json: nil,status: 200

			end
			# End destroy :-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:

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