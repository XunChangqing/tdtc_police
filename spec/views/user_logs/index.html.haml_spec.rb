require 'rails_helper'

RSpec.describe "user_logs/index", type: :view do
  before(:each) do
    assign(:user_logs, [
      UserLog.create!(
        :user => nil,
        :operation => "Operation",
        :target_user => "Target User",
        :remark => "MyText"
      ),
      UserLog.create!(
        :user => nil,
        :operation => "Operation",
        :target_user => "Target User",
        :remark => "MyText"
      )
    ])
  end

  it "renders a list of user_logs" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Operation".to_s, :count => 2
    assert_select "tr>td", :text => "Target User".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
