require 'rails_helper'

RSpec.describe BoxesController, type: :controller do 
  describe "#create" do 
    include_context "admin_user_for_session"

    subject{post :create, params: params}

    context "when user not signed in" do 
      let(:params){}

      it_behaves_like "not_signed_user"
    end

    context "when no selected account" do 
      let(:params){}

      include_context "sign_in"

      it_behaves_like "not_account_selected"
    end

    context "when user signed in and account selected" do 
      let(:params){}
      include_context "sign_in_and_select_account"

    end
  end
end