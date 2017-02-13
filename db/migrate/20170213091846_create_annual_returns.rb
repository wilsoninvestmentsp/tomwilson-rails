class CreateAnnualReturns < ActiveRecord::Migration
  def change
    create_table :annual_returns do |t|
      t.references :syndication, index: true
      t.integer :year
      t.integer :projected_annual_return
      t.integer :actual_annual_return
      t.integer :quarter_1
      t.integer :quarter_2
      t.integer :quarter_3
      t.integer :quarter_4
      t.timestamps null: false
    end
  end
end
