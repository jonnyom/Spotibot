# frozen_string_literal: true

class SpotifyOauthController < ApplicationController

  def callback
    # create user here
    render body: nil, status: :ok
  end

end
