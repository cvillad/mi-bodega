class Account < ApplicationRecord
  before_save -> {self.subdomain = subdomain.downcase}
  validates :name, presence: true 
  validates :plan, presence: true
  validates :subdomain, presence: true, uniqueness: {case_sensitive: false}

  has_many :members
  has_many :users, through: :members
  belongs_to :user
end
