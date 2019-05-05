require "spec_helper"

describe UsersController, type: :controller do

  describe ".index" do
    it "responds successfully" do
      get :index
      expect(response.status).to eq(200)
    end
  end

end
