require 'rails_helper'

shared_context "admin_user_for_session" do 
  let(:user) { create :user }
  let(:account) { create :account, user: user }
  let(:member) { create :member, user: user, account: account }
end

shared_context "user_for_session" do 
  let(:account) { create :account }
  let(:user) { create :user }
  let(:member) { create :member, user: user, account: account }
end

shared_context "sign_in" do 
  before{ 
    member
    sign_in user
  }
end

shared_context "sign_in_and_select_account" do 
  before{ 
    member
    user.update(current_tenant_id: account.id)
    sign_in user
  }
end