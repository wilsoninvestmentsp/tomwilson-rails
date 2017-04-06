class AddStatusAndLocationToSyndication < ActiveRecord::Migration
  def change
    add_column :syndications, :status, :string
    add_column :syndications, :location, :string
  end
end