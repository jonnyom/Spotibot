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
      spotify_user = RSpotify::User.new(request.env["omniauth.auth"])
      expect(User).to receive(:create!).with(spotify_id: spotify_user.id,
                                             email: spotify_user.email,
                                             full_name: spotify_user.display_name,
                                             spotify_hash: spotify_user.to_hash
      )
      get :callback
      expect(session[:spotify_user_id]).to be_present
      expect(response).to redirect_to("/")
    end

  end
end
