class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :full_name, limit: 255
      t.string :spotify_id
      t.string :email
      t.timestamps
    end
  end
end
