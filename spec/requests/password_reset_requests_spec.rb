require 'rails_helper'

RSpec.describe "PasswordResetRequests", type: :request do
  describe "GET /password_reset_requests" do
    it "works! (now write some real specs)" do
      get password_reset_requests_path
      expect(response).to have_http_status(200)
    end
  end
end
