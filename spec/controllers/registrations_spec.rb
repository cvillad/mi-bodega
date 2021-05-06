require 'rails_helper' 

RSpec.describe Users::RegistrationsController, type: :controller do 
  before{request.env["devise.mapping"] = Devise.mappings[:user]}

  describe "#create" do 
    shared_examples_for "user_creation" do 
      it "should create a user" do 
        expect{subject}.to change{User.count}.by(1)
      end

      it "should create a member" do 
        expect{subject}.to change{Member.count}.by(1)
      end

      it "should create an account" do 
        expect{subject}.to change{Account.count}.by(1)
      end
    end

    subject {post :create, params: params }
    
    context "when provided data is valid" do
      describe "and plan is free" do 
        let(:params) do 
          {
            user: {
              email: "example@example.com",
              password: "secret",
              password_confirmation: "secret",
              account_attributes: {
                name: "example account",
                subdomain: "example",
                plan: "free"
              }
            }
          }
        end

        it_behaves_like "user_creation"
      end

      describe "and plan is not free" do 
        let(:params) do 
          {
            user: {
              email: "example@example.com",
              password: "secret",
              password_confirmation: "secret",
              account_attributes: {
                name: "example account",
                subdomain: "example",
                plan: "moderate"
              }
            },
            payment_method: {
              number: "4242424242424242",
              cvc: "145",
              exp_month: "12",
              exp_year: "2025"
            }
          }
        end
        it_behaves_like "user_creation"
      end
    end
  end

  describe "#destroy" do 
    subject { delete :destroy }

    let(:common_user) { create :user }
    let(:common_member) {create :member, account: account, user: common_user}

    include_context "admin_user_for_session"
    shared_examples_for "user_destroy" do 
      it "should delete a user" do 
        expect{subject}.to change{User.count}.by(-1)
      end

      it "should redirect to root path" do 
        subject 
        expect(response).to redirect_to("#{request.protocol+request.host_with_port}/")
      end
    end
    
    context "when user signed in" do 
      describe "admin user" do 
        include_context "sign_in"
        it_behaves_like "user_destroy"
        it "should delete an account" do 
          expect{subject}.to change{Account.count}.by(-1)
        end
      end

      describe "common user" do 
        before{ sign_in common_user }

        it_behaves_like "user_destroy"
      end
    end

    context "when selected account" do 
      describe "admin user" do
        include_context "sign_in_and_select_account"
        it_behaves_like "user_destroy"
        it "should delete an account" do 
          expect{subject}.to change{Account.count}.by(-1)
        end
      end

      describe "common user" do 
        before{ 
          common_user.update(current_tenant_id: account.id)
          sign_in common_user
        }

        it_behaves_like "user_destroy"
      end
    end
  end
end