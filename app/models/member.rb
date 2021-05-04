class Member < ApplicationRecord
  belongs_to :user
  belongs_to :account
  has_many :boxes, dependent: :destroy
  has_one :item
end
