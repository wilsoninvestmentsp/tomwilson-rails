class ChangeOrdertoSort < ActiveRecord::Migration
  def change
  	rename_column :users,:order,:sort
  	rename_column :testimonies,:order,:sort
  end
end