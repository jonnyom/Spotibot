require "spec_helper"

describe UsersController, type: :controller do

  describe ".index" do
    it "redirects if the user is logged out" do
      get :index
      expect(response.status).to eq(302)
      expect(response).to redirect_to("/login")
    end

    it "responds successfully when the user is logged in" do
      session[:spotify_user_id] = "test"
      get :index
      expect(response.status).to eq(200)
    end
  end

  describe ".logout" do
    before { session[:spotify_user_id] = "test" }

    it "deletes the session variable" do
      expect(session[:spotify_user_id]).to be_present
      get :logout
      expect(session[:spotify_user_id]).to_not be_present
    end
  end

  describe ".login" do
    it "responds successfully" do
      get :login
      expect(response.status).to eq(200)
    end
  end

end
