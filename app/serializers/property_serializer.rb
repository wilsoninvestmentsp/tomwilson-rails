class PropertySerializer < ActiveModel::Serializer

	# has_many :images
	# has_many :links

	attributes(
		:id,
		:building_type,
		:raw_building_type,
		:address,
		:raw_address,
		:year_built,
		:square_ft,
		:offer_price,
		:raw_offer_price,
		:rent,
		:raw_rent,
		:status,
		:raw_status,
		:leased,
		:bedrooms,
		:bathrooms,
		:garages,
		# :carports,
		:monthly_return,
		:chart,
		:city,
		:state,
		:zip,
		:title,
		:raw_title,
		:highlight,
		:offer_price_label,
		:description,
		:featured,
		:slug,
		:cash_flow,
		:raw_cash_flow,
		:lot_size,
		:school_district,
		:raw_school_district,
		:active,
		:property_management_fee,
		:mortgage_payment,
		:hoa_fee,
		:property_tax,
		:hazard_insurance,
		:image
	)

	private

	def helper
		@helper ||= Class.new do
			include ActionView::Helpers::NumberHelper
		end.new
	end

end