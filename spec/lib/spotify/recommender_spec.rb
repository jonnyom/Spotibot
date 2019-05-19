require "spec_helper"

describe Spotify::Recommender do
  let(:user) { double(User, spotify_hash: {}) }
  let(:spotify_user) { double(RSpotify::User, top_artists: nil, saved_tracks?: nil, saved_albums?: nil) }
  let(:track1) { double(RSpotify::Track, id: "123", name: "We don't like you", album: album1) }
  let(:track2) { double(RSpotify::Track, id: "456", name: "The Funk, It Hurts", album: album2) }
  let(:album1) { double(RSpotify::Album, id: "123", name: "We're having fun, why aren't you?", artist: artist1) }
  let(:album2) { double(RSpotify::Album, id: "456", name: "Funky boogie woogie", artist: artist2) }
  let(:artist1) { double(RSpotify::Artist, id: "123", name: "Funk Lords unite") }
  let(:artist2) { double(RSpotify::Artist, id: "456", name: "Actually Just Racists") }
  let(:recommendations) { double(RSpotify::Recommendations, tracks: [track1, track2]) }
  let(:top_artists) { [artist1, artist2] }
  let(:recommender) { described_class.new(user: user) }

  before do
    allow(RSpotify::User).to receive(:new).and_return(spotify_user)
    allow(RSpotify::Recommendations).to receive(:generate).and_return(recommendations)
  end

  context "when the top artists are returned correctly" do
    before do
      allow(spotify_user).to receive(:top_artists).and_return(top_artists)
      allow(spotify_user).to receive(:saved_tracks?).and_return(saved_tracks)
      allow(spotify_user).to receive(:saved_albums?).and_return(saved_albums)
    end

    context "when an unsaved album is found on the first element of the sample set" do
      let(:saved_tracks) { [false, false] }
      let(:saved_albums) { [false, false] }

      it "returns the first album" do
        expect(RSpotify::Recommendations).to receive(:generate).twice
        expect(recommender.recommendation).to eq(album1)
      end
    end

    context "when an unsaved album is found on the second element of the sample set" do
      let(:saved_tracks) { [true, false] }
      let(:saved_albums) { [true, false] }

      it "returns the second album" do
        expect(recommender.recommendation.name).to eq(album2.name)
      end
    end

    context "when no unsaved albums exist" do
      let(:saved_albums) { [true, true] }
      let(:saved_tracks) { [true, true] }

      it "attempts to find more and raises a RecommendationNotFound error when none are found" do
        expect { recommender.recommendation }.to raise_error(Spotify::RecommendationNotFoundError)
      end
    end
  end


end
