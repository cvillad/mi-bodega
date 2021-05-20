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
      within "" do 
      end
      # expect{
      #   click_link "New item"
      #   all(".nested-fields").last.fill_in "Description", with: "sample-description"
      #   all(".nested-fields").last.attach_file("image", "spec/images/mona.jpeg")
      #   click_button "Create Box"
      #   expect(page).to have_content "Box was successfully created"
      # }.to change{ account.boxes.count }.by(1)
    end
  end

  context "use item" do 
    let(:box) { create :box, account: account }
    let(:item) { create :item, box: box }

    before { item }

    scenario "should update using_by to current_user id" do 
      login_user(user)
      select_account(account)
      visit box_path(box)
      expect(page).to have_current_path box_path(box)
      click_link "Use"
      expect(page).to have_content "using this item now"
      item.reload
      expect(item.using_by).to eq(member)
    end
  end

  context "move item" do
    let(:box) { create :box, account: account }
    let(:item) { create :item, box: box }
    let(:another_box) { create :box, account: account, name: "bad-box" }

    before { 
      item
      another_box
    }

    scenario "should update box_id of the item" do
      login_user(user)
      select_account(account)
      visit box_path(box)
      expect(page).to have_current_path box_path(box)
      within "#modal-window" do 
        byebug
        select another_box.name, from: "#{item.description} to box"
      end
      # click_link "Move"
      # select another_box.name, from: "To box"
      # click_button "Move"
      # expect(page).to have_content("Item moved to")
      # item.reload
      # expect(item.box_id).to eq(another_box.id)
    end
  end
end
