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