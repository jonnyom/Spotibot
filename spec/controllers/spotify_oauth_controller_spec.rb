require "spec_helper"

describe SpotifyOauthController, type: :controller do

  describe ".callback" do
    it "responds successfully" do
      get :callback
      expect(response).to be_successful
    end

  end
end
