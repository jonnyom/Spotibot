require "spec_helper"

describe Workers::User::Recommender do

  let!(:user1) { create(:user) }
  let!(:user2) { create(:user) }

  it "finds the recommendations for the two users" do
    recommender1 = double(Spotify::Recommender, user: user1)
    recommender2 = double(Spotify::Recommender, user: user2)
    expect(Spotify::Recommender).to receive(:new).with(user: user1).and_return(recommender1)
    expect(Spotify::Recommender).to receive(:new).with(user: user2).and_return(recommender2)
    expect(recommender1).to receive(:recommendation).once
    expect(recommender2).to receive(:recommendation).once
    recommender.run
  end

  def recommender
    @recommender ||= Workers::User::Recommender
  end

end
