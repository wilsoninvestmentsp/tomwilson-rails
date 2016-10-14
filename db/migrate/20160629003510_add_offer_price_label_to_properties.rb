class AddOfferPriceLabelToProperties < ActiveRecord::Migration
  def change
  	add_column :properties, :offer_price_label, :string
  end
end