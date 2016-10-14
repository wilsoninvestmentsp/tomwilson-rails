class CreateCharts < ActiveRecord::Migration
  def change
    create_table :charts do |t|
      t.integer :property_id
      t.string :title
      t.decimal :value,precision: 15,scale: 2

      t.timestamps null: false
    end
  end
end
