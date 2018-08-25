class AddCorrectFieldsToSlackChannel < ActiveRecord::Migration[5.1]
  def change
    add_column :slack_channels, :slack_user_id, :string
    add_column :slack_channels, :slack_user_access_token, :string
    add_column :slack_channels, :slack_bot_user_id, :string
    add_column :slack_channels, :slack_bot_access_token, :string
  end
end
