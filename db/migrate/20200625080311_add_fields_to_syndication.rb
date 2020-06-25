class AddFieldsToSyndication < ActiveRecord::Migration
  def change
    add_column :syndications, :exit_date, :date
    add_column :syndications, :actual_average_annual_return, :string
    add_column :syndications, :actual_irr, :string
    add_column :syndications, :actual_hold_period, :string
  end
end
