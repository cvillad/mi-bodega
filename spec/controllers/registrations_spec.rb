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
end