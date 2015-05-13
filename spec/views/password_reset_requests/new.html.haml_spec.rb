require 'rails_helper'

RSpec.describe "password_reset_requests/new", type: :view do
  before(:each) do
    assign(:password_reset_request, PasswordResetRequest.new(
      :user => nil,
      :remark => "MyText",
      :status => "MyString"
    ))
  end

  it "renders new password_reset_request form" do
    render

    assert_select "form[action=?][method=?]", password_reset_requests_path, "post" do

      assert_select "input#password_reset_request_user_id[name=?]", "password_reset_request[user_id]"

      assert_select "textarea#password_reset_request_remark[name=?]", "password_reset_request[remark]"

      assert_select "input#password_reset_request_status[name=?]", "password_reset_request[status]"
    end
  end
end
