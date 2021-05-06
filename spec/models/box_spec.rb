require 'rails_helper'

RSpec.describe Box, type: :model do
  describe "#validations" do 
    let(:box) { create :box }
    it "should validate factory" do 
      expect(box).to be_valid
    end

    # it "should validate presence of account" do 
    #   box.account = nil
    #   expect(box).not_to be_valid 
    #   expect(box.errors[:account]).to include("must exist")
    # end
  end
end
