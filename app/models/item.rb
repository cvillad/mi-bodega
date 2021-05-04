class Item < ApplicationRecord
  belongs_to :box
  belongs_to :member, optional: true
  has_one_attached :image
  validates :image, presence: true
  validates :description, presence: true
end
