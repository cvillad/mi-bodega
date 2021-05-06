require 'rails_helper'

RSpec.describe Member, type: :model do
  describe "#validations" do 
    let(:member) {create :member}

    it "should validate factory" do 
      expect(member).to be_valid
    end

    it "should validate presence of account" do 
      member.account = nil
      expect(member).not_to be_valid
      expect(member.errors[:account]).to include("must exist")
    end

    it "should validate presence of user" do 
      member.user = nil
      expect(member).not_to be_valid
      expect(member.errors[:user]).to include("must exist")
    end
  end
end
