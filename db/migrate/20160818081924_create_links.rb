class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.integer :property_id
      t.string :title
      t.string :link

      t.timestamps null: false
    end
  end
end
