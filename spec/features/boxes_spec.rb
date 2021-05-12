require 'rails_helper'
#NOT WORKING
RSpec.feature "Boxes", type: :feature do
  include_context "admin_user_for_session"
  before{ member }

  context "create box" do 
    scenario "should create a box" do 
      login_user(user)
      select_account(account)
      expect(page).to have_current_path boxes_path
      click_link "New Box"
      fill_in "Name", with: "sample-box"
      # expect{
      #   #click_link "New item"
      #   #all(".nested-fields").last.fill_in "Description", with: "sample-description"
      #   #all(".nested-fields").last.attach_file("image", "spec/images/mona.jpeg")
      #   click_button "Create Box"
      #   expect(page).to have_content "Box was successfully created"
      # }.to change{ account.boxes.count }.by(1)
    end
  end

  context "use item" do 
    let(:box_1) { create :box, account: account, member: member }
    let(:item) { create :item, box: box_1 }
    before{ item }
    scenario "should update using_by to current_user id" do 
      login_user(user)
      select_account(account)
      visit box_path(box_1)
      expect(page).to have_current_path box_path(box_1)
      click_link "Use"
      expect(page).to have_content "using this item now"
      expect(item.using_by).to be_truthy
    end
  end

  context "move item" do
    let(:box_1) { create :box, account: account, member: member }
    let(:box_2) { create :box, account: account, member: member }
    let(:item) { create :item, box: box_1 }
    scenario "should update box_id of the item" do
      login_user(user)
      select_account(account)
      visit box_path(box_1)
      expect(page).to have_current_path box_path(box_1)
      click_link "Move"
    end
  end
end
