require "spec_helper"

describe SpotifyOauthController, type: :controller do

  before do
    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:spotify]
  end

  let(:spotify_auth_hash) do
    {
      provider: "spotify",
      uid: "1199355469",
      info: {
        display_name: nil,
        email: "jonathanomahony@gmail.com",
        external_urls: {
          spotify: "https: //open.spotify.com/user/1199355469"
        },
        followers: {
          href: nil,
          total: 46
        },
        href: "https: //api.spotify.com/v1/users/1199355469",
        id: "1199355469",
        images: [],
        type: "user",
        uri: "spotify:user:1199355469"
      },
      credentials:{
        token: "<TOKEN>",
        refresh_token: "<REFRESH_TOKEN>",
        expires_at: 1557084545,
        expires: true
      },
      extra: {
        raw_info: {
          display_name: nil,
          email: "jonathanomahony@gmail.com",
          external_urls: {
            spotify: "https://open.spotify.com/user/1199355469"
          },
          followers: {
            href: nil,
            total: 46
          },
          href: "https: //api.spotify.com/v1/users/1199355469",
          id: "1199355469",
          images: [],
          type: "user",
          uri: "spotify:user:1199355469"
        }
      }
    }
  end

  describe ".callback" do
    it "responds successfully" do
      expect(User).to receive(:create!).with(spotify_id: spotify_auth_hash[:uid],
                                             email: spotify_auth_hash[:info][:email],
                                             full_name: spotify_auth_hash[:info][:display_name]
      )
      get :callback
      expect(response).to be_successful
    end

  end
end
