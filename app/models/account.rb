class Account < ApplicationRecord
  validates :name, presence: true, uniqueness: {case_sensitive: false}
  validates :plan, presence: true

  has_many :members, dependent: :destroy
  has_many :users, through: :members
  has_many :boxes, dependent: :destroy
  has_one :payment_method, dependent: :destroy
  belongs_to :user
  before_destroy :delete_stripe_customer

  def delete_stripe_customer
    Stripe::Customer.delete(stripe_customer_id) if stripe_customer_id
  end

  def subscribe(payment_method_params)
    price = Plan.stripe_prices[plan.to_sym]
    token = Stripe::Token::create({card: payment_method_params})[:id]
    customer = Stripe::Customer.create email: user.email, source: token
    card = Stripe::Customer.list_sources(customer[:id])[:data].first
    create_payment_method(brand: card[:brand], 
                    exp_month: card[:exp_month], 
                    exp_year: card[:exp_year], 
                    stripe_id: card[:id], 
                    last4: card[:last4])
    update(stripe_customer_id: customer[:id])
    Stripe::Subscription.create({
      customer: customer[:id],
      items: [
        {price: price},
      ],
    })
  end
end
