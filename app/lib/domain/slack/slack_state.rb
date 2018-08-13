# frozen_string_literal: true

module Domain
  module Slack
    class SlackState

      attr_accessor :oauth_token, :app_id, :admin_id

      def initialize(state)
        oauth_token_id, @app_id, @admin_id = URI.unescape(state).split(":")
        @oauth_token_id = oauth_token_id.to_i
      end

      def valid?
        @oauth_token_id.present? && @app_id.present? && @admin_id.present?
      end

    end
  end
end
