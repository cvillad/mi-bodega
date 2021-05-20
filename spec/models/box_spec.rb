require 'rails_helper'

RSpec.describe Box, type: :model do
  describe "#validations" do 
    let(:account) { create :account, plan: "moderate" }
    let(:box) { build :box, account: account }
    it "is valid" do 
      byebug
      expect(box).to be_valid
    end

    it "is invalid without name" do 
      box.name = nil
      expect(box).not_to be_valid
      expect(box.errors[:name]).to include("can't be blank")
    end

    it "is invalid cause uniqueness with case sensitive set to false" do 
      another_box = create :box, name: box.name.capitalize, account: box.account
      expect(box).not_to be_valid 
      expect(box.errors[:name]).to include("has already been taken")
    end

    it "does not allow equal names in the same account" do 
      another_box = create :box, name: box.name, account: box.account
      expect(box).not_to be_valid 
      expect(box.errors[:name]).to include("has already been taken")
    end

    it "allow equal names in different accounts" do 
      another_box = create :box, name: box.name
      expect(box).to be_valid 
    end
  end
end
