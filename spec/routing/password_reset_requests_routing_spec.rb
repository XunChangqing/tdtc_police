require "rails_helper"

RSpec.describe PasswordResetRequestsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/password_reset_requests").to route_to("password_reset_requests#index")
    end

    it "routes to #new" do
      expect(:get => "/password_reset_requests/new").to route_to("password_reset_requests#new")
    end

    it "routes to #show" do
      expect(:get => "/password_reset_requests/1").to route_to("password_reset_requests#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/password_reset_requests/1/edit").to route_to("password_reset_requests#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/password_reset_requests").to route_to("password_reset_requests#create")
    end

    it "routes to #update" do
      expect(:put => "/password_reset_requests/1").to route_to("password_reset_requests#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/password_reset_requests/1").to route_to("password_reset_requests#destroy", :id => "1")
    end

  end
end
