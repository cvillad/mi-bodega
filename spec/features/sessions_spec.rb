require 'rails_helper'

RSpec.describe "session" do 
  context "when user is registered" do 
    describe "and is admin user" do 
      include_context "admin_user_for_session"
      it_behaves_like "user_login"
    end

    describe "and is a common user" do 
      include_context "user_for_session"
      it_behaves_like "user_login"
    end
  end
  
  context "when user is not registered" do 
    scenario "User is not registered" do 
      visit root_path 
      click_link "Sign in"
      fill_in "Email", with: "example@test.com"
      fill_in "Password", with: "secret"
      click_button "Log in"

      expect(page).to have_current_path "/users/sign_in"
      expect(page).to have_content "Invalid Email or password"
    end
  end

end