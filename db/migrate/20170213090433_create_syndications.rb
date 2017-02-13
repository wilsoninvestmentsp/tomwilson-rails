class CreateSyndications < ActiveRecord::Migration
  def change
    create_table :syndications do |t|
      t.string :title
      t.string :slug, unique: true, index: true
      t.integer :purchase_price
      t.integer :raise_amount
      t.integer :hold_period
      t.integer :preferred_return
      t.float :average_annual_return
      t.float :irr
      t.date :close_date
      t.integer :price_per_share
      t.integer :loan_amount
      t.float :loan_rate
      t.integer :year_built
      t.float :building_size
      t.float :lot_size
      t.integer :number_of_buildings
      t.string :property_type
      t.integer :number_of_tenants
      t.string :image
      t.string :notes
      t.boolean :active, default: true
      t.timestamps null: false
    end
  end
end