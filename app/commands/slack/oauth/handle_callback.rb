# frozen_string_literal: true

module Slack
  module Oauth
    class HandleCallback < Mutations::Command

      required do
        string :code
      end

      def execute
        return update_slack_channel! unless slack_channel.blank?
        create_slack_channel
      end

      private def slack_access_token
        @slack_access_token ||= ::Slack::Oauth::FetchAccessToken.run!(code: code)
      end

      private def slack_channel
        @slack_channel ||= Slack::SlackChannel.find_by(channel_id: slack_access_token["incoming_webhook"]["channel_id"])
      end

      private def update_slack_channel!
        slack_channel.update_attributes!(
          slack_user_id: slack_access_token["user_id"],
          slack_user_access_token: slack_access_token["access_token"],
          slack_bot_user_id: slack_access_token["bot"]["bot_user_id"],
          slack_bot_access_token: slack_access_token["bot"]["bot_access_token"]
        )
      end

      private def create_slack_channel
        Slack::SlackChannel.create(
          channel_id: slack_access_token["incoming_webhook"]["channel_id"],
          channel_name: slack_access_token["incoming_webhook"]["channel"],
          slack_user_id: slack_access_token["user_id"],
          slack_user_access_token: slack_access_token["access_token"],
          slack_bot_user_id: slack_access_token["bot"]["bot_user_id"],
          slack_bot_access_token: slack_access_token["bot"]["bot_access_token"]
        )
      end

    end
  end
end
