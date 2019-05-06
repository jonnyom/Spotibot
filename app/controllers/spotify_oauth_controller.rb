# frozen_string_literal: true

class SpotifyOauthController < ApplicationController

  def callback
    User.create!(spotify_id: spotify_user.id,
                 full_name: spotify_user.display_name,
                 email: spotify_user.email,
                 spotify_hash: spotify_user.to_hash)
    session[:spotify_user_id] = spotify_user.id
    redirect_to "/", status: 302
  end

  private def spotify_user
    @spotify_user ||= RSpotify::User.new(request.env["omniauth.auth"])
  end

end
