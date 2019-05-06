class AddUserHashToUserModel < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :spotify_hash, :jsonb, null: false, default: {}
  end
end
