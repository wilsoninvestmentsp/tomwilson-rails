class AddPieChartDataToProperties < ActiveRecord::Migration
  def change

  	add_column :properties,:property_management_fee,:decimal,precision: 15,scale: 2
  	add_column :properties,:mortgage_payment,:decimal,precision: 15,scale: 2
  	add_column :properties,:hoa_fee,:decimal,precision: 15,scale: 2
  	add_column :properties,:property_tax,:decimal,precision: 15,scale: 2
  	add_column :properties,:hazard_insurance,:decimal,precision: 15,scale: 2

  end
end