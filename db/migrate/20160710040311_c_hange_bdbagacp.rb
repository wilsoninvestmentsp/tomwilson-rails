class CHangeBdbagacp < ActiveRecord::Migration
  def change
  	change_column :properties,:bedrooms,:decimal,precision: 15,scale: 2
  	change_column :properties,:bathrooms,:decimal,precision: 15,scale: 2
  	change_column :properties,:garages,:decimal,precision: 15,scale: 2
  	change_column :properties,:carports,:decimal,precision: 15,scale: 2
  end
end