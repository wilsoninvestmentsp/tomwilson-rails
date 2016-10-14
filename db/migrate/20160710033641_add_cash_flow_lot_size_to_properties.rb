class AddCashFlowLotSizeToProperties < ActiveRecord::Migration
  def change
  	add_column :properties,:cash_flow,:decimal,precision: 15,scale: 2
  	add_column :properties,:lot_size,:integer
  end
end