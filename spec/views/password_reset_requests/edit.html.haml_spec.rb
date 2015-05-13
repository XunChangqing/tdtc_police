require 'rails_helper'

RSpec.describe "password_reset_requests/edit", type: :view do
  before(:each) do
    @password_reset_request = assign(:password_reset_request, PasswordResetRequest.create!(
      :user => nil,
      :remark => "MyText",
      :status => "MyString"
    ))
  end

  it "renders the edit password_reset_request form" do
    render

    assert_select "form[action=?][method=?]", password_reset_request_path(@password_reset_request), "post" do

      assert_select "input#password_reset_request_user_id[name=?]", "password_reset_request[user_id]"

      assert_select "textarea#password_reset_request_remark[name=?]", "password_reset_request[remark]"

      assert_select "input#password_reset_request_status[name=?]", "password_reset_request[status]"
    end
  end
end
