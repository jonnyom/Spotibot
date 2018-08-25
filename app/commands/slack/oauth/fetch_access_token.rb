# frozen_string_literal: true

module Slack
  module Oauth
    class FetchAccessToken < Slack::Api::Common

      required do
        string :code
      end

      def execute
        response = ::Slack::Web::Client.new.oauth_access({ client_id: ENV["SLACK_CLIENT_ID"],
                                                           client_secret: Rails.application.secrets.slack_secret,
                                                           redirect_uri: SLACK_OAUTH_REDIRECT_URL,
                                                           code: code })
        raise ::Slack::Web::Api::Errors::SlackError.new("Authentication failed") unless is_okay?(response)
        response
      end

    end
  end
end
