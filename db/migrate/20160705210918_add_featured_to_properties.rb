class AddFeaturedToProperties < ActiveRecord::Migration
	
	def change

		add_column :properties,:featured,:integer

	end

end