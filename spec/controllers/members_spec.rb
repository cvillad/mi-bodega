require 'rails_helper'

RSpec.describe MembersController, type: :controller do 
  describe "#create" do 
    include_context "admin_user_for_session"

    subject { post :create, params: params }
    context "when user not signed in" do 
      let(:params){}

      it_behaves_like "not_signed_user"
    end

    context "when no selected account" do 
      let(:params){}

      include_context "sign_in"

      it_behaves_like "not_account_selected"
    end

    context "when user signed in" do
      include_context "sign_in_and_select_account"

      describe "and valid data provided" do 
        context "but invited user does not exists" do 
          let(:params) do 
            {
              user: {
                email: "invited@example.com"
              }
            }
          end

          it "should redirect to members path" do 
            subject 
            expect(flash[:notice]).to include("invitation sent")
            expect(response).to redirect_to("#{request.protocol}#{request.host_with_port}/members")
          end

          it "should create a user" do 
            expect{subject}.to change{User.count}.by(1)
          end

          it "should create a member" do 
            expect{subject}.to change{Member.count}.by(1)
          end
        end

        context "but invited user exists" do 
          let(:invited_user) {create :user}
          let(:params) do 
            {
              user: {
                email: invited_user.email
              }
            }
          end

          before{ invited_user }

          it "should redirect to members path" do 
            subject 
            expect(flash[:notice]).to include("added successfully")
            expect(response).to redirect_to("#{request.protocol}#{request.host_with_port}/members")
          end

          it "should not create a user" do 
            expect{subject}.not_to change{User.count}
          end

          it "should create a member" do 
            expect{subject}.to change{Member.count}.by(1)
          end
        end

        context "but invited user is a member of the account" do 
          let(:invited_user) {create :user}
          let(:invited_member) {create :member, user: invited_user, account: account}
          let(:params) do 
            {
              user: {
                email: invited_user.email
              }
            }
          end

          before{ 
            invited_user
            invited_member
          }

          it "should redirect to members path" do 
            subject 
            expect(flash[:alert]).to include("is a member already")
            expect(response).to render_template("new")
          end

          it "should not create a user" do 
            expect{subject}.not_to change{User.count}
          end

          it "should create a member" do 
            expect{subject}.not_to change{Member.count}
          end
        end
      end
    end
  end
end