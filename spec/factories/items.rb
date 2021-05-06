FactoryBot.define do
  factory :item do
    description { "sample-description" }
    image { ActiveStorage::Blob.create_and_upload!(
      io: File.open("spec/images/mona.jpeg", 'rb'),
      filename: 'image',
      content_type: 'image/jpeg'
  ) }
    association :box
  end
end
