module Api
	module V1
		class LinksController < ApplicationController
			
			respond_to :json

			# Begin create :-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:
			def create
			
				@link = Link.new params.require(:link).permit :title,:link,:property_id

				if @link.save

					render json: @link,status: 201

				else

					render json: {errors: @link.errors},status: 422

				end
			
			end
			# End create :-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:

			# Begin update :-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:
			def update
			
				@link = Link.find params[:id]

				if @link.update params.require(:link).permit :title,:link,:property_id

					render json: @link,status: 200

				else

					render json: {errors: @link.errors},status: 422

				end
			
			end
			# End update :-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:

			# Begin destroy :-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:
			def destroy
			
				@link = Link.find params[:id]
				@link.destroy

				render json: nil,status: 200
			
			end
			# End destroy :-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:

		end
	end
end