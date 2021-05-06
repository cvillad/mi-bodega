require 'rails_helper'

RSpec.describe "Registrations" do 
  scenario "when select free plan" do 
    visit new_user_registration_path
    fill_in "Email", with: "test@example.com"
    fill_in "Password", with: "secret"
    fill_in "Password confirmation", with: "secret"
    fill_in "Account name", with: "sample-account"
    find("#tenant_plan").select "Free"
    
    expect{click_button "Sign up"}.to change{
      User.count
      Account.count
      Member.count
    }.by(1)
  end
end