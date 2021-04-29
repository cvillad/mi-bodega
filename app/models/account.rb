class Account < ApplicationRecord
  validates :name, presence: true 
  validates :plan, presence: true

  has_many :members, dependent: :destroy
  belongs_to :user
end
