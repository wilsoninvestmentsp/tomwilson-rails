module Api
	module V1
		class ChartsController < ApplicationController
			
			respond_to :json

			# Begin create :-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:
			def create
			
				@chart = Chart.new params.require(:chart).permit :title,:value,:property_id

				if @chart.save

					render json: @chart,status: 201

				else

					render json: {errors: @chart.errors},status: 422

				end
			
			end
			# End create :-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:

			# Begin destroy :-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:
			def destroy
			
				Chart.find(params[:id]).destroy

				render json: nil,status: 200
			
			end
			# End destroy :-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:

		end
	end
end