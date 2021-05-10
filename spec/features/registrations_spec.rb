require 'rails_helper'

RSpec.describe "Registrations" do 
  include_context "admin_user_for_session"
  
  scenario "when user does not exists" do 
    visit new_user_registration_path
    fill_in "Email", with: "test@example.com"
    fill_in "Password", with: "secret"
    fill_in "Password confirmation", with: "secret"
    fill_in "Account name", with: "sample-account"
    find("#tenant_plan").select "Free"
    
    expect{
      click_button "Sign up"
      expect(page).to have_current_path accounts_path 
      expect(page).to have_content "signed up successfully"
    }.to change{
      User.count
      Account.count
      Member.count
    }.by(1)
  end

  scenario "when user exists" do 
    visit new_user_registration_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    fill_in "Password confirmation", with: user.password
    fill_in "Account name", with: "sample-account"
    find("#tenant_plan").select "Free"
    
    expect{
      click_button "Sign up"
      expect(page).to have_content "Email has already been taken"
    }.not_to change{
      User.count
      Account.count
      Member.count
    }
  end
end