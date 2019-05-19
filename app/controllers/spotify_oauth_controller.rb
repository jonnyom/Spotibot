# frozen_string_literal: true

class SpotifyOauthController < ApplicationController

  def callback
    user = User.create!(spotify_id: spotify_user.id,
                 full_name: spotify_user.display_name,
                 email: spotify_user.email,
                 spotify_hash: spotify_user.to_hash)
    session[:spotify_user_id] = spotify_user.id
    intercom_client.users.create(email: spotify_user.email, user_id: spotify_user.id, name: spotify_user.display_name)
    send_recommendation(user)
    redirect_to "/", status: 302
  end

  private def send_recommendation(user)
    recommendation = Spotify::Recommender.new(user: user).recommendation
    Intercom::Email.new(user: user, recommendation: recommendation).send_recommendation
  end

  private def spotify_user
    @spotify_user ||= RSpotify::User.new(request.env["omniauth.auth"])
  end

  private def intercom_client
    @intercom_client ||= Intercom::Client.new(token: Rails.application.credentials.intercom_pat)
  end

end
