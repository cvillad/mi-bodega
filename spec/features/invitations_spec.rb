require 'rails_helper'

RSpec.describe "Invitations" do 
  include_context "admin_user_for_session"
  
  before do
    member
    visit root_path 
    click_link "Sign in"
    fill_in "Email", with: user.email 
    fill_in "Password", with: user.password 
    click_button "Log in"
    click_link account.name
    visit members_path
    click_link "Add a member"
  end

  scenario "when invited user does not exists" do
    fill_in "Email", with: "invited@test.com"
    expect{
      click_button "Invite user"
      expect(page).to have_current_path members_path
      expect(page).to have_content "Email invitation sent to invited@test.com"
    }.to change{
      User.count 
      Member.count 
    }.by(1)
  end

  scenario "when invited user exists" do 
    user = create :user

    fill_in "Email", with: user.email 
    expect{
      click_button "Invite user"
      expect(page).to have_current_path members_path
      expect(page).to have_content "#{user.email} added successfully"
    }.to change{
      Member.count
    }
  end

  scenario "when invited user is a member of the account" do 
    user = create :user
    member = create :member, user: user, account: account

    fill_in "Email", with: user.email 
    expect{
      click_button "Invite user"
      expect(page).to have_current_path members_path
      expect(page).to have_content "#{user.email} is a member already"
    }.not_to change{
      User.count 
      Member.count
    }
  end
end