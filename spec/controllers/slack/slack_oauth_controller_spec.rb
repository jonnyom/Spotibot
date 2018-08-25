# frozen_string_literal: true

require "spec_helper"

describe Slack::SlackOauthController, type: :controller do
  let(:code) { "<code>" }
  let(:state) { "" }
  let(:params) { { code: code, state: state } }
  let(:access_token) { "<access-token>" }
  let(:bot_access_token) { "<bot-access-token>" }
  let(:slack_team) { "<team-name" }
  let(:slack_user_id) { "<user-id>" }
  let(:scope) { "<scopes>" }
  let(:configuration_url) { "<config-url>" }
  let(:slack_url) { "<slack-url>" }
  let(:channel_name) { "<channel-name>" }
  let(:channel_id) { "<channel-id>" }
  let(:team_id) { "<team-id>" }
  let(:bot_user_id) { "<bot-user-id>" }

  let(:slack_response) { {
    "ok"=>true,
    "access_token"=> access_token,
    "scope"=>scope,
    "user_id"=>slack_user_id,
    "team_name"=>slack_team,
    "team_id"=>team_id,
    "incoming_webhook"=>{
      "channel"=>channel_name,
      "channel_id"=> channel_id,
      "configuration_url"=>configuration_url,
      "url"=>slack_url
    },
    "bot"=> {
      "bot_user_id"=>bot_user_id,
      "bot_access_token"=>bot_access_token
    }
  } }

  before do
    allow(Slack::Oauth::FetchAccessToken).to receive(:run!).and_return(slack_response)
  end

  describe "#callback" do
    it "returns no content" do
      get :callback, params: params
      expect(response.status).to eq(204)
    end

    it "handles the callback" do
      expect(Slack::Oauth::HandleCallback).to receive(:run!).with(code: code)
      get :callback, params: params
    end
  end

end
