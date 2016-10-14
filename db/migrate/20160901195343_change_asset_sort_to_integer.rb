class ChangeAssetSortToInteger < ActiveRecord::Migration
  def change
  	change_column :jassets,:sort,:integer
  end
end