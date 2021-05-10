require 'rails_helper'

RSpec.feature "Boxes", type: :feature do
  include_context "user_for_session" #creates user and member for an account

  before{ member }

  scenario "should create a box" do 
    login_user(user)
    select_account(account)
    expect(page).to have_current_path boxes_path
    expect{
      click_link "New Box"
      fill_in "Name", with: "sample-box"
      #click_link "New item"
      #all(".nested-fields").last.fill_in "Description", with: "sample-description"
      #all(".nested-fields").last.attach_file("image", "spec/images/mona.jpeg")
      click_button "Create Box"
      expect(page).to have_content "Box was successfully created"
    }.to change{ account.boxes.count }.by(1)
  end
end
