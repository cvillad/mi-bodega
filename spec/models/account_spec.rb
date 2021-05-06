require 'rails_helper'

RSpec.describe Account, type: :model do
  describe "#validations" do 
    let(:account) { build :account }
    it "should validate factory" do 
      expect(account).to be_valid
    end

    it "should validate presence of name" do 
      account.name = nil
      expect(account).not_to be_valid
      expect(account.errors[:name]).to include("can't be blank")
    end

    it "should validate uniqueness of name" do 
      new_account = create :account, name: account.name 
      expect(account).not_to be_valid
      expect(account.errors[:name].first).to include("already been taken")
    end

    it "should validate plan" do 
      account.plan = nil
      expect(account).not_to be_valid 
      expect(account.errors[:plan]).to include("can't be blank")
    end

    it "should validate plan name" do 
      account.plan = "noplan"
      expect(account).not_to be_valid 
      expect(account.errors[:plan]).to include("must be valid")
    end
  end
end
