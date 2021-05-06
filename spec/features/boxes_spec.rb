require 'rails_helper'

RSpec.feature "Boxes", type: :feature do
  scenario "user create a box with item" do 
    user = create :user
    account = create :account, user: user
    member = create :member, user: user, account: account
    visit root_path 
    click_link "Sign in"
    fill_in "Email", with: user.email 
    fill_in "Password", with: user.password 
    click_button "Log in"

    expect(page).to have_current_path "/accounts"
    expect(page).to have_content "Signed in successfully"

    click_link account.name
    expect(page).to have_content "- #{account.name} (#{account.plan})"
    expect(page).to have_content "Boxes"
    expect(page).to have_current_path "/boxes"
    expect{
      click_link "New Box"
      fill_in "Name", with: "sample-box"
      #click_link "New item"
      #all(".nested-fields").last.fill_in "Description", with: "sample-description"
      all(".nested-fields").last.attach_file("image", "spec/images/mona.jpeg")
      click_button "Create Box"
      expect(page).to have_content "Box was successfully created"
    }.to change(account.boxes, :count).by(1)
  end
end
