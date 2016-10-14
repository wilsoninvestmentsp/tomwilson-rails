class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :role
      t.string :phone
      t.string :image
      t.text :description

      t.timestamps null: false
    end
  end
end