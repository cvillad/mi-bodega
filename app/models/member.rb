class Member < ApplicationRecord
  belongs_to :user
  belongs_to :account
  has_many :boxes, dependent: :destroy
  has_one :using_item, class_name: "Item", foreign_key: "using_by_id"
end
