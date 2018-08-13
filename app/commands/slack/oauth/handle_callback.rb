# frozen_string_literal: true

module Slack
  module Oauth
    class HandleCallback < Mutations::Command

      required do
        string :code
        string :state
        duck :session
      end

      def execute

      end

      private def slack_access_token!
        @slack_access_token ||= ::Slack::Oauth::FetchAccessToken.run!(code: code)
      end

      private def slack_channel
        @slack_channel ||= SlackChannel.find_by(slack_channel_id)
      end

      private def slack_channel_id
        @slack_channeL_id ||= session[:channel_id]
      end

    end
  end
end
