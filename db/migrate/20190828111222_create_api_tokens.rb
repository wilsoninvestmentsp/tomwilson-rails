class CreateApiTokens < ActiveRecord::Migration
  def change
    create_table :api_tokens do |t|
      t.string :access_token
      t.string :refresh_token
      t.string :platform
      t.datetime :expire_on

      t.timestamps null: false
    end
  end
end
