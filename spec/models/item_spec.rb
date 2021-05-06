require 'rails_helper'

RSpec.describe Item, type: :model do
  describe "#validations" do 

    let(:item) {create :item}

    it "should validate factory" do 
      expect(item).to be_valid
    end

    it "should validate box association" do 
      item.box = nil 
      expect(item).not_to be_valid 
      expect(item.errors[:box]).to include("must exist")
    end

    it "should validate presence image" do 
      item.image = nil 
      expect(item).not_to be_valid 
      expect(item.errors[:image]).to include("can't be blank")
    end

    it "should validate image type" do 
      item.image = ActiveStorage::Blob.create_and_upload!(
        io: File.open("spec/images/test.pdf", 'rb'),
        filename: 'image',
        content_type: 'application/pdf')
      expect(item).not_to be_valid 
      expect(item.errors[:image].first).to include("invalid content type")
    end
  end
end
