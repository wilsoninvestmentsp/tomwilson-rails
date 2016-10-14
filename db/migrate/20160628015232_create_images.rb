class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.integer :property_id

      t.timestamps null: false
    end
  end
end
