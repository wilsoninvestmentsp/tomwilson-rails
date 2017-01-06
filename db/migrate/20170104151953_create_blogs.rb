class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :title
      t.text :content
      t.string :summary
      t.date :date
      t.string :image
      t.string :slug, unique: true, index: true
      t.timestamps null: false
    end
  end
end
