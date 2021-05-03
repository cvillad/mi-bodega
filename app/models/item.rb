class Item < ApplicationRecord
  belongs_to :box
  has_one_attached :image
  validates :image, presence: true
  validates :description, presence: true
end
