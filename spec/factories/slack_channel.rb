FactoryBot.define do
  factory :slack_channel, class: Slack::SlackChannel do
    channel_id { "<channel-id>" }
    slack_user_id { "<user-id>" }
    channel_name { "<channel>" }
    slack_user_access_token { "<access-token>" }
    slack_bot_access_token { "<bot-access-token>" }
    slack_bot_user_id { "" }
  end
end
