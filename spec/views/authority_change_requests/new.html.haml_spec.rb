require 'rails_helper'

RSpec.describe "authority_change_requests/new", type: :view do
  before(:each) do
    assign(:authority_change_request, AuthorityChangeRequest.new(
      :user => nil,
      :src_authority => 1,
      :dst_authority => 1,
      :user_remark => "MyText",
      :manager_remark => "MyText",
      :status => "MyString"
    ))
  end

  it "renders new authority_change_request form" do
    render

    assert_select "form[action=?][method=?]", authority_change_requests_path, "post" do

      assert_select "input#authority_change_request_user_id[name=?]", "authority_change_request[user_id]"

      assert_select "input#authority_change_request_src_authority[name=?]", "authority_change_request[src_authority]"

      assert_select "input#authority_change_request_dst_authority[name=?]", "authority_change_request[dst_authority]"

      assert_select "textarea#authority_change_request_user_remark[name=?]", "authority_change_request[user_remark]"

      assert_select "textarea#authority_change_request_manager_remark[name=?]", "authority_change_request[manager_remark]"

      assert_select "input#authority_change_request_status[name=?]", "authority_change_request[status]"
    end
  end
end
