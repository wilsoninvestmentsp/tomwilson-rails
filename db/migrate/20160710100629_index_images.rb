class IndexImages < ActiveRecord::Migration
  def change
  	add_index :images,:property_id
  end
end