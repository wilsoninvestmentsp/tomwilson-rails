module Api
	module V1
		class TestimoniesController < ApplicationController
			
			respond_to :json

			# Begin Index :-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:
			def index

				q = QueryTools.query params

				@testimonies = Testimony.where(q)
				.page(params[:page])
				.per_page((params[:limit] || 100).to_i)
				.order(params[:order])

				respond_with @testimonies,
				meta: {
					current_page: @testimonies.current_page,
					next_page: @testimonies.next_page,
					prev_page: @testimonies.previous_page,
					total_pages: @testimonies.total_pages,
					total_count: @testimonies.count,
					limit: (params[:limit] || 100).to_i
				}

			end
			# End Index :-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:

			# Begin create :-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:
			def create

				tparams = params.require(:testimony).permit :quote,:author

				@testimony = Testimony.new tparams

				if @testimony.save

					render json: @testimony,status: 201

				else

					render json: {errors: @testimony.errors},status: 422

				end

			end
			# End create :-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:

			# Begin update :-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:
			def update
				
				tparams = params.require(:testimony).permit :quote,:author,:sort,:created_at,:updated_at

				@testimony = Testimony.find params[:id]

				if @testimony.update(tparams)

					render json: nil,status: 200

				else

					render json: nil,status: 422

				end

			end
			# End update :-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:

			# Begin destroy :-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:
			def destroy
			
				Testimony.find(params[:id]).destroy

				render json: nil,status: 200
			
			end
			# End destroy :-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:

			# Begin Order  :-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:
			def order

				testimonies = params.require(:testimonies)

				order = {}
				testimonies.each_with_index do |id,i|

					order.merge! id => {sort: i}

				end

				if Testimony.update(order.keys,order.values)

					render json: nil,status: 200

				else

					render json: nil,status: 422

				end

			end
			# End Order  :-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:

		end
	end
end