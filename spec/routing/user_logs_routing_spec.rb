require "rails_helper"

RSpec.describe UserLogsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/user_logs").to route_to("user_logs#index")
    end

    it "routes to #new" do
      expect(:get => "/user_logs/new").to route_to("user_logs#new")
    end

    it "routes to #show" do
      expect(:get => "/user_logs/1").to route_to("user_logs#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/user_logs/1/edit").to route_to("user_logs#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/user_logs").to route_to("user_logs#create")
    end

    it "routes to #update" do
      expect(:put => "/user_logs/1").to route_to("user_logs#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/user_logs/1").to route_to("user_logs#destroy", :id => "1")
    end

  end
end
