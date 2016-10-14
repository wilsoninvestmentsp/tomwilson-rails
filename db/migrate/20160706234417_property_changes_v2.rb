class PropertyChangesV2 < ActiveRecord::Migration

	def change

		change_column :properties,:bedrooms,:decimal,precision: 3,scale: 2
		change_column :properties,:bathrooms,:decimal,precision: 3,scale: 2
		change_column :properties,:carports,:decimal,precision: 3,scale: 2
		change_column :properties,:garages,:decimal,precision: 3,scale: 2

	end

end