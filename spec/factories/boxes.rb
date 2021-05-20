FactoryBot.define do
  factory :box do
    association :account
    sequence(:name) { |n| "sample-box-#{n}" }
  end
end
