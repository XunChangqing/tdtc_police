require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #total" do
    it "returns http success" do
      get :total
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #node" do
    it "returns http success" do
      get :node
      expect(response).to have_http_status(:success)
    end
  end

end
