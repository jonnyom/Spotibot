# frozen_string_literal: true

require "spec_helper"

describe Domain::Slack::SlackState do

  context "validate slack state" do

    it "returns true if state has oauth token, app id, admin id" do
      slack_state = ::Domain::Slack::SlackState.new("oauth_token:app_id:admin_id")
      expect(slack_state.valid?).to eq(true)
    end

    it "returns false if it is not in the correct format" do
      slack_state = ::Domain::Slack::SlackState.new("oauth_token:app_id")
      expect(slack_state.valid?).to eq(false)
    end
  end
end
