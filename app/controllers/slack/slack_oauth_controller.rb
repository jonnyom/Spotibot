# frozen_string_literal: true

module Slack
  class SlackOauthController < ApplicationController

    def callback
      head 204
    end

  end
end
