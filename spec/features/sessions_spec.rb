require 'rails_helper'

RSpec.describe "session" do 
  include_context "admin_user_for_session"
  
  scenario "User is registered" do 
    visit root_path 
    click_link "Sign in"
    fill_in "Email", with: user.email 
    fill_in "Password", with: user.password 
    click_button "Log in"

    expect(page).to have_current_path "/accounts"
    expect(page).to have_content "Signed in successfully"
  end

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