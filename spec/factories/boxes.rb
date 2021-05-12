FactoryBot.define do
  factory :box do
    association :account
    name { "sample-box" }
  end
end
