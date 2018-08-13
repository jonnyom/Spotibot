# frozen_string_literal: true

module Slack
  module Api
    class Common < Mutations::Command

      def is_okay?(response)
        response.present? && response["ok"] == true
      end

    end
  end
end
