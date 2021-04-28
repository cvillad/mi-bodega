class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable 

  has_many :members, dependent: :destroy
  has_one :account, dependent: :destroy
  accepts_nested_attributes_for :account

  def self.create_member(params)
  end
end
