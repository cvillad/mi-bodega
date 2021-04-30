class Account < ApplicationRecord
  before_save -> {self.subdomain = subdomain.downcase}
  validates :name, presence: true 
  validates :plan, presence: true
  validates :subdomain, presence: true, uniqueness: {case_sensitive: false}

  has_many :members
  has_many :users, through: :members
  belongs_to :user

  def subscribe(payment_method_params)
    price = Plan.stripe_prices[plan.to_sym]
    token = Stripe::Token::create({card: payment_method_params})[:id]
    customer = Stripe::Customer.create email: user.email, source: token
    update(stripe_customer_id: customer[:id])
    Stripe::Subscription.create({
      customer: customer[:id],
      items: [
        {price: price},
      ],
    })
  end
end
