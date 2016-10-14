class AddHighlightToProperty < ActiveRecord::Migration
  def change
  	add_column :properties,:highlight,:string
  end
end