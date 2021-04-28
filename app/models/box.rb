class Box < ApplicationRecord
  acts_as_tenant :account
end
