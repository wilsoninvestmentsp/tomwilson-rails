class AddUrlToMeetupEvent < ActiveRecord::Migration
  def change
    add_column :meetup_events, :url, :string
  end
end
