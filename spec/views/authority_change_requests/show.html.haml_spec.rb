require 'rails_helper'

RSpec.describe "authority_change_requests/show", type: :view do
  before(:each) do
    @authority_change_request = assign(:authority_change_request, AuthorityChangeRequest.create!(
      :user => nil,
      :src_authority => 1,
      :dst_authority => 2,
      :user_remark => "MyText",
      :manager_remark => "MyText",
      :status => "Status"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Status/)
  end
end
