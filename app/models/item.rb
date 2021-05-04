class Item < ApplicationRecord
  belongs_to :box
  belongs_to :using_by, class_name: "Member", foreign_key: "using_by_id", optional: true
  has_one :user, through: :using_by
  has_one_attached :image
  validates :image, presence: true
  validates :description, presence: true
end
