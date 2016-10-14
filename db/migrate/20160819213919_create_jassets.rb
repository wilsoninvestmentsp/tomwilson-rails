class CreateJassets < ActiveRecord::Migration
  def change
    create_table :jassets do |t|
      t.string :title
      t.text :description
      t.string :link_name
      t.string :link_uri
      t.string :sort
      t.string :image

      t.timestamps null: false
    end
  end
end
