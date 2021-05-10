class Member < ApplicationRecord
  belongs_to :user
  belongs_to :account
  has_many :boxes, dependent: :destroy
  has_many :using_items, class_name: "Item", foreign_key: "using_by_id", dependent: :destroy
end
