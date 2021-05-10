require 'rails_helper'

RSpec.describe "Invitations" do 
  include_context "admin_user_for_session" #user, member, account

  before do
    member
    login_user(user)
    select_account(account)
    visit members_path
    click_link "Add a member"
  end

  context "when invited user does not exists" do 
    scenario "should create an user and member" do
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
  end

  context "when invited user exists" do 
    describe "invited user is not member of the account" do 
      scenario "should create a member" do 
        user = create :user

        fill_in "Email", with: user.email 
        expect{
          click_button "Invite user"
          expect(page).to have_current_path members_path
          expect(page).to have_content "#{user.email} added successfully"
        }.to change{ Member.count }.by(1)
      end
    end

    describe "invited user is a member of the account" do 
      scenario "should not create a member" do 
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
  end
end