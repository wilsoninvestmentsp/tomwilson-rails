class AddStatusAndAuthorToBlog < ActiveRecord::Migration
  def change
    add_column :blogs, :status, :integer, default: 1 # 0 - blog is inactive, 1 - blog is active
    add_column :blogs, :author, :string, default: ''
  end
end