FactoryBot.define do
  factory :account do
    sequence(:name) { |n| "Account-#{n}" }
    plan { "free" }
    association :user
  end
end
