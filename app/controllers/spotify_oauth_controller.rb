# frozen_string_literal: true

class SpotifyOauthController < ApplicationController

  def callback
    User.create!(spotify_id: spotify_user.id,
                 full_name: spotify_user.display_name,
                 email: spotify_user.email,
                 spotify_hash: spotify_user.to_hash)
    intercom_client.users.create(email: spotify_user.email, user_id: spotify_user.id, name: spotify_user.display_name)
    session[:spotify_user_id] = spotify_user.id
    redirect_to "/", status: 302
  end

  private def spotify_user
    @spotify_user ||= RSpotify::User.new(request.env["omniauth.auth"])
  end

  private def intercom_client
    @intercom_client ||= Intercom::Client.new(token: Rails.application.credentials.intercom_pat)
  end

end
