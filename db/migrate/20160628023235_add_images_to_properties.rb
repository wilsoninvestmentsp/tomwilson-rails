class AddImagesToProperties < ActiveRecord::Migration
  def change
  	add_column :properties,:images,:string
  end
end