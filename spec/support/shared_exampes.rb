require 'rails_helper'

shared_examples_for "not_signed_user" do 
  let(:path){ "#{request.protocol}#{request.host_with_port}" }
  before{ subject }

  it "should redirect to sign in path" do 
    subject 
    expect(subject).to redirect_to("#{path}/users/sign_in")
  end
end

shared_examples_for "not_account_selected" do 
  let(:path){ "#{request.protocol}#{request.host_with_port}" }
  before{ subject }

  it "should redirect to accounts path" do 
    subject 
    expect(subject).to redirect_to("#{path}/accounts")
  end
end

shared_examples_for "user_login" do   
  scenario "proper login" do 
    visit root_path 
    click_link "Sign in"
    fill_in "Email", with: user.email 
    fill_in "Password", with: user.password 
    click_button "Log in"

    expect(page).to have_current_path "/accounts"
    expect(page).to have_content "Signed in successfully"
  end
end