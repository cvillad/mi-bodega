class Account < ApplicationRecord
  validates :name, presence: true 
  validates :plan, presence: true
  
  has_many :members
  has_many :users, through: :members
  belongs_to :user
end
