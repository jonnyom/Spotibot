# frozen_string_literal: true

class SpotifyOauthController < ApplicationController

  def callback
    # create user here
    User.create!(spotify_id: spotify_user.id,
                 full_name: spotify_user.display_name,
                 email: spotify_user.email,
                 spotify_hash: spotify_user.to_hash)
    render body: nil, status: :ok
  end

  private def spotify_user
    @spotify_user ||= RSpotify::User.new(request.env["omniauth.auth"])
  end

end
