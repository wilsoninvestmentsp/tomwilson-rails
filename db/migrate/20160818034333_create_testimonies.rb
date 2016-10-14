class CreateTestimonies < ActiveRecord::Migration
  def change
    create_table :testimonies do |t|
      t.text :quote
      t.string :author
      t.integer :order

      t.timestamps null: false
    end
  end
end
