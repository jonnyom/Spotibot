require "spec_helper"

describe Slack::Oauth::HandleCallback do
  subject { described_class.run!(params) }

  let(:code) { "<code>" }
  let(:params) { { code: code} }
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

  context "when a slack channel doesn't exist" do
    it "creates a new slack channel" do
      expect(Slack::Oauth::FetchAccessToken).to receive(:run!).with(code: code).and_return(slack_response)
      subject

      slack_channel = Slack::SlackChannel.find_by(channel_id: channel_id)
      expect(slack_channel.channel_name).to eq(channel_name)
      expect(slack_channel.slack_user_id).to eq(slack_user_id)
      expect(slack_channel.slack_user_access_token).to eq(access_token)
      expect(slack_channel.slack_bot_user_id).to eq(bot_user_id)
      expect(slack_channel.slack_bot_access_token).to eq(bot_access_token)
    end
  end

  context "when a slack channel does exist" do
    let!(:slack_channel) { create(:slack_channel, channel_id: channel_id) }
    let(:access_token) { "<new-access-token>" }
    let(:bot_access_token) { "<new-bot-token>" }
    let(:bot_user_id) { "<new-bot-id>" }

    it "updates the existing channel" do
      expect(Slack::Oauth::FetchAccessToken).to receive(:run!).with(code: code).and_return(slack_response)
      expect(Slack::SlackChannel).not_to receive(:create)
      expect{ subject }.not_to change{ Slack::SlackChannel.count }

      subject

      slack_channel = Slack::SlackChannel.find_by(channel_id: channel_id)
      expect(slack_channel.slack_user_id).to eq(slack_user_id)
      expect(slack_channel.slack_user_access_token).to eq(access_token)
      expect(slack_channel.slack_bot_user_id).to eq(bot_user_id)
      expect(slack_channel.slack_bot_access_token).to eq(bot_access_token)
    end
  end
end
