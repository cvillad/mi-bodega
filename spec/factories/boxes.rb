FactoryBot.define do
  factory :box do
    association :user
    name { "MyString" }
  end
end
