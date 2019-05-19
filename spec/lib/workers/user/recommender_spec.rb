require "spec_helper"

describe Workers::User::Recommender do

  let!(:user1) { create(:user) }
  let!(:user2) { create(:user) }
  let(:recommender1) { double(Spotify::Recommender, user: user1) }
  let(:recommender2) { double(Spotify::Recommender, user: user2) }
  let(:recommendation1) { double(RSpotify::Album, name: "Test Album") }
  let(:recommendation2) { double(RSpotify::Album, name: "Test Album 2, Electric Boogaloo") }
  let(:emailer1) { double(Intercom::Email, user: user1, recommendation: recommendation1) }
  let(:emailer2) { double(Intercom::Email, user: user2, recommendation: recommendation2) }

  it "finds the recommendations for the two users" do
    expect(Spotify::Recommender).to receive(:new).with(user: user1).and_return(recommender1)
    expect(Spotify::Recommender).to receive(:new).with(user: user2).and_return(recommender2)
    expect(recommender1).to receive(:recommendation).once.and_return(recommendation1)
    expect(recommender2).to receive(:recommendation).once.and_return(recommendation2)
    expect(Intercom::Email).to receive(:new).with(user: user1, recommendation: recommendation1).and_return(emailer1)
    expect(Intercom::Email).to receive(:new).with(user: user2, recommendation: recommendation2).and_return(emailer2)
    expect(emailer1).to receive(:send_recommendation).once
    expect(emailer2).to receive(:send_recommendation).once
    described_class.run
  end

end
