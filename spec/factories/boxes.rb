FactoryBot.define do
  factory :box do
    association :account
    association :member
    name { "sample-box" }
  end
end
