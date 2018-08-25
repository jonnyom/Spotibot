# frozen_string_literal: true

module Slack
  class SlackOauthController < ApplicationController

    def callback
      Slack::Oauth::HandleCallback.run!(code: code)
      head :no_content
    end

    private def code
      params.require(:code)
    end

  end
end
