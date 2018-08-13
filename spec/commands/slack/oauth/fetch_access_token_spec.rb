# frozen_string_literal: true

require "spec_helper"

describe Slack::Oauth::FetchAccessToken do

  subject { described_class.run!(code: code) }
  let(:code) { "example_code" }
  let(:client) { double("::Slack::Web::Client", new: nil, oauth_token: nil) }
  let(:successful_response) { { "ok" => true } }

  before do
    allow(::Slack::Web::Client).to receive(:new).and_return(client)
  end

  it "fetches the correct access token" do
    expect(client).to receive(:oauth_access).with({ client_id: Rails.application.secrets.slack_client_id,
                                                    client_secret: Rails.application.secrets.slack_client_secret,
                                                    redirect_uri: ::SLACK_OAUTH_REDIRECT_URL,
                                                    code: code })
                              .and_return(successful_response)
    subject
  end

end
