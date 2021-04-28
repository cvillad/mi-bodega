require 'rails_helper'

RSpec.describe "boxes/index", type: :view do
  before(:each) do
    assign(:boxes, [
      Box.create!(
        account: nil,
        name: "Name"
      ),
      Box.create!(
        account: nil,
        name: "Name"
      )
    ])
  end

  it "renders a list of boxes" do
    render
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: "Name".to_s, count: 2
  end
end
