require 'rails_helper'

RSpec.describe "UserLogs", type: :request do
  describe "GET /user_logs" do
    it "works! (now write some real specs)" do
      get user_logs_path
      expect(response).to have_http_status(200)
    end
  end
end
