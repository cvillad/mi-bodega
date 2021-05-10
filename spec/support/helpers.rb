require 'rails_helper'

def login_user(user)
  visit root_path 
  click_link "Sign in"
  fill_in "Email", with: user.email 
  fill_in "Password", with: user.password 
  click_button "Log in"
  expect(page).to have_current_path accounts_path
  expect(page).to have_content "Signed in successfully"
end

def select_account(account)
  visit accounts_path
  click_link account.name
  expect(page).to have_current_path boxes_path
end