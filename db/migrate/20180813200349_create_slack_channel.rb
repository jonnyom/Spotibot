class CreateSlackChannel < ActiveRecord::Migration[5.1]
  def change
    create_table :slack_channels do |t|
      t.string :channel_id, null: false
      t.string :channel_name, null: false
    end
  end
end
