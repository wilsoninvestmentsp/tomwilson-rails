class ChartSerializer < ActiveModel::Serializer

	attributes :id,:title,:value,:raw_value,:property_id,:created_at,:updated_at

end