require 'rails_helper'

RSpec.describe RegistrationsController, type: :controller do

  describe "GET #signup" do
    it "returns http success" do
      get :signup
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #reset_password" do
    it "returns http success" do
      get :reset_password
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #logout" do
    it "returns http success" do
      get :logout
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #create" do
    it "returns http success" do
      get :create
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #update" do
    it "returns http success" do
      get :update
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #profile" do
    it "returns http success" do
      get :profile
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #edit_profile" do
    it "returns http success" do
      get :edit_profile
      expect(response).to have_http_status(:success)
    end
  end

end
