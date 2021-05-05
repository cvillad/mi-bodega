FactoryBot.define do
  factory :member do
    association :user
    association :account
  end
end
