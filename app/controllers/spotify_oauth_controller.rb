# frozen_string_literal: true

class SpotifyOauthController < ApplicationController

  def callback
    # create user here
    User.create!(spotify_id: spotify_user.id, full_name: spotify_user.display_name, email: spotify_user.email)
    render body: nil, status: :ok
  end

  private def spotify_user
    @spotify_user ||= RSpotify::User.new(request.env["omniauth.auth"])
  end

end
