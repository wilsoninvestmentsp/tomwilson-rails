class AddMainImageToProperties < ActiveRecord::Migration
  def change
  	add_column :properties,:image,:string
  end
end