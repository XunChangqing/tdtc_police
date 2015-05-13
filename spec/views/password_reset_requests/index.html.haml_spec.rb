require 'rails_helper'

RSpec.describe "password_reset_requests/index", type: :view do
  before(:each) do
    assign(:password_reset_requests, [
      PasswordResetRequest.create!(
        :user => nil,
        :remark => "MyText",
        :status => "Status"
      ),
      PasswordResetRequest.create!(
        :user => nil,
        :remark => "MyText",
        :status => "Status"
      )
    ])
  end

  it "renders a list of password_reset_requests" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Status".to_s, :count => 2
  end
end
