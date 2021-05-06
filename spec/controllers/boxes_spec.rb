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
      let(:box) { create :box, account: account }
      let(:img) { File.open("spec/images/mona.jpeg", 'rb') }
      let(:params) do 
        {
          box: {
            name: "sample-box"
          },
          items_attributes: {
            description: "sample-description",
            image: img
          }
        }
      end
      include_context "sign_in_and_select_account"
      subject{ post :create, params: params }

      it "should redirect to box path" do 
        subject 
        expect(response).to redirect_to("#{request.protocol+request.host_with_port}/boxes/#{Box.last.id}")
      end

      it "should create a box" do 
        expect{subject}.to change{Box.count}.by(1)
      end

      it "should create an item" do 
        expect{subject}.to change{Box.count}.by(1)
      end
    end
  end
end