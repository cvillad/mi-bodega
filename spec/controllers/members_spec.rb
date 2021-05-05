require 'rails_helper'

RSpec.describe MembersController, type: :controller do 
  describe "#create" do 
    let(:user) { create :user }
    let(:account) { create :account, user: user }
    let(:member) { create :member, user: user, account: account }

    before{ 
      member
      user.update(current_tenant_id: account.id)
      sign_in user
    }

    subject { post :create, params: params }

    context "when invited user does not exists" do 
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

    context "when invited user exists" do 
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
  end
end