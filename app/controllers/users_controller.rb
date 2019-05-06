# frozen_string_literal: true

class UsersController < ApplicationController

  def index
    redirect_to "/login" if session[:spotify_user_id].blank?
  end

  def login
  end

  def logout
    session.delete(:spotify_user_id)
    redirect_to "/login"
  end

end
