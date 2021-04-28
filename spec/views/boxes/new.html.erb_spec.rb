require 'rails_helper'

RSpec.describe "boxes/new", type: :view do
  before(:each) do
    assign(:box, Box.new(
      account: nil,
      name: "MyString"
    ))
  end

  it "renders new box form" do
    render

    assert_select "form[action=?][method=?]", boxes_path, "post" do

      assert_select "input[name=?]", "box[account_id]"

      assert_select "input[name=?]", "box[name]"
    end
  end
end
