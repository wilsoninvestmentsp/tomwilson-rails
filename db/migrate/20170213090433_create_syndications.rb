class CreateSyndications < ActiveRecord::Migration
  def change
    create_table :syndications do |t|
      t.string :title
      t.string :slug, unique: true, index: true
      t.integer :purchase_price
      t.integer :raise_amount
      t.string :hold_period
      t.string :preferred_return
      t.string :average_annual_return
      t.string :irr
      t.date :close_date
      t.integer :price_per_share
      t.integer :loan_amount
      t.string :loan_rate
      t.string :year_built
      t.integer :building_size
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