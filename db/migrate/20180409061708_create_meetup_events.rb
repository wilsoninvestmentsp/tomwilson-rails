class CreateMeetupEvents < ActiveRecord::Migration
  def change
    create_table :meetup_events do |t|
      t.string :title
      t.text :description
      t.string :meetup_image
      t.boolean :status

      t.timestamps null: false
    end
  end
end
