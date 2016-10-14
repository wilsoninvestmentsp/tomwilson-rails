class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.integer :user_id
      t.string :type
      t.string :name
      t.string :status

      t.timestamps null: false
    end
  end
end
