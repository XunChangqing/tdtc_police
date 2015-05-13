require 'rails_helper'

RSpec.describe "user_logs/new", type: :view do
  before(:each) do
    assign(:user_log, UserLog.new(
      :user => nil,
      :operation => "MyString",
      :target_user => "MyString",
      :remark => "MyText"
    ))
  end

  it "renders new user_log form" do
    render

    assert_select "form[action=?][method=?]", user_logs_path, "post" do

      assert_select "input#user_log_user_id[name=?]", "user_log[user_id]"

      assert_select "input#user_log_operation[name=?]", "user_log[operation]"

      assert_select "input#user_log_target_user[name=?]", "user_log[target_user]"

      assert_select "textarea#user_log_remark[name=?]", "user_log[remark]"
    end
  end
end
