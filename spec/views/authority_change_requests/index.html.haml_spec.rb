require 'rails_helper'

RSpec.describe "authority_change_requests/index", type: :view do
  before(:each) do
    assign(:authority_change_requests, [
      AuthorityChangeRequest.create!(
        :user => nil,
        :src_authority => 1,
        :dst_authority => 2,
        :user_remark => "MyText",
        :manager_remark => "MyText",
        :status => "Status"
      ),
      AuthorityChangeRequest.create!(
        :user => nil,
        :src_authority => 1,
        :dst_authority => 2,
        :user_remark => "MyText",
        :manager_remark => "MyText",
        :status => "Status"
      )
    ])
  end

  it "renders a list of authority_change_requests" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Status".to_s, :count => 2
  end
end
