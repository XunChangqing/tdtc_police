require 'rails_helper'

RSpec.describe "user_logs/show", type: :view do
  before(:each) do
    @user_log = assign(:user_log, UserLog.create!(
      :user => nil,
      :operation => "Operation",
      :target_user => "Target User",
      :remark => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Operation/)
    expect(rendered).to match(/Target User/)
    expect(rendered).to match(/MyText/)
  end
end
