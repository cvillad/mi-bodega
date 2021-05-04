class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :invitable,
         :recoverable, :rememberable, :validatable, :confirmable 

  has_many :members, dependent: :destroy
  has_many :accounts, through: :members
  has_many :boxes, through: :members
  has_one :item, through: :members
  has_one :account, dependent: :destroy
  belongs_to :current_tenant, class_name: "Account", foreign_key: "current_tenant_id", optional: true
  accepts_nested_attributes_for :account

  def is_admin?(tenant_id)
    account&.id == tenant_id
  end

  def username 
    email.slice(0...email.index("@"))
  end
end
