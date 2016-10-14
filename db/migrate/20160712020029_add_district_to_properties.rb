class AddDistrictToProperties < ActiveRecord::Migration
  def change
  	add_column :properties,:school_district,:string
  end
end