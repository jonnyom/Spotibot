require "spec_helper"

describe ::Intercom::Email do
  let(:intercom_email) { described_class.new(user: user, recommendation: recommendation) }
  let(:recommendation) do
    double("RSpotify::Album",
           name: "Test Album",
           external_urls: { "spotify" => "https://testing.com" },
           artists: artists
    )
  end
  let(:artists) { [double("RSpotify::Artist", name: "Test Artist")] }
  let(:user) { FactoryBot.create(:user) }
  let(:intercom_client) { double("Intercom::Client", users: intercom_users) }
  let(:intercom_users) { double("Intercom::Client::User") }
  let(:intercom_user) { Intercom::User.new(id: "1234abc", user_id: user.spotify_id, email: user.email, name: user.full_name) }
  let(:intercom_message) { Intercom::Message.new(message_type: "email", body: message_body, to: { type: "user", id: intercom_user.id }) }
  let(:message_body) { "Here's your daily recommendation:\n#{recommendation.name} by #{artists.first.name}\n#{recommendation.external_urls["spotify"]}" }
  let(:expected_message) do
    {
      message_type: "email",
      from: { type: "admin", id: described_class::ADMIN_ID },
      to: { type: "user", id: intercom_user.id },
      template: "personal",
      body: message_body,
      subject: "Your daily album"
    }
  end

  before do
    expect(Intercom::Client).to receive(:new).and_return(intercom_client)
    expect(intercom_client).to receive(:users).and_return(intercom_users)
  end

  # TODO: fix this test. Something's wrong with how I'm mocking find
  # context "when the user isn't found in Intercom" do
  #   before { allow(intercom_users).to receive(:find).with(user_id: user.spotify_id).and_raise(::Intercom::ResourceNotFound) }
  #
  #   it "creates the user and sends the email to the user" do
  #     expect(intercom_users).to receive(:create).and_return(intercom_user)
  #     expect(intercom_client).to receive_message_chain(:messages, :create).with(expected_message).and_return(intercom_message)
  #     intercom_email.send_recommendation
  #   end
  # end

  context "with a valid user found in Intercom" do
    it "sends the email to the user" do
      expect(intercom_users).to receive(:find).with(user_id: user.spotify_id).and_return(intercom_user)
      expect(intercom_client).to receive_message_chain(:messages, :create).with(expected_message).and_return(intercom_message)
      intercom_email.send_recommendation
    end
  end

end
