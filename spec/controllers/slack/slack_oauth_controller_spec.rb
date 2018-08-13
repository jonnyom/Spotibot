# frozen_string_literal: true

require "spec_helper"

describe Slack::SlackOauthController, type: :controller do

  describe "#callback" do
    it "returns no content" do
      get :callback
      expect(response.status).to eq(204)
    end
  end

end
