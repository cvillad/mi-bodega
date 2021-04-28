class Account < ApplicationRecord
  validates :name, presence: true 
  validates :plan, presence: true
end
