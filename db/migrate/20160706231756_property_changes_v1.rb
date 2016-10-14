class PropertyChangesV1 < ActiveRecord::Migration

	def change

		add_column :properties,:building_type,:string
		change_column :properties,:leased,:string,default: 'no'

	end

end