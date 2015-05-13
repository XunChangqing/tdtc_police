require 'rails_helper'

RSpec.describe "password_reset_requests/show", type: :view do
  before(:each) do
    @password_reset_request = assign(:password_reset_request, PasswordResetRequest.create!(
      :user => nil,
      :remark => "MyText",
      :status => "Status"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Status/)
  end
end
