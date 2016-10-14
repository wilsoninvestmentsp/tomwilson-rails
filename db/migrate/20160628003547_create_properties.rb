class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.string :address
      t.integer :year_built
      t.integer :square_ft
      t.decimal :offer_price,precision: 15,scale: 2
      t.decimal :rent,precision: 15,scale: 2
      t.string :status
      t.boolean :leased
      t.integer :bedrooms
      t.integer :bathrooms
      t.integer :garages
      t.integer :carports
      t.decimal :monthly_return,precision: 15,scale: 2

      t.timestamps null: false
    end
  end
end