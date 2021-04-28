class Account < ApplicationRecord
  validates :name, presence: true 
  validates :plan, presence: true

  has_many :members
  belongs_to :user
end
