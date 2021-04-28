require 'rails_helper'

RSpec.describe "boxes/edit", type: :view do
  before(:each) do
    @box = assign(:box, Box.create!(
      account: nil,
      name: "MyString"
    ))
  end

  it "renders the edit box form" do
    render

    assert_select "form[action=?][method=?]", box_path(@box), "post" do

      assert_select "input[name=?]", "box[account_id]"

      assert_select "input[name=?]", "box[name]"
    end
  end
end
