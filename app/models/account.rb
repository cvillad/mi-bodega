class Account < ApplicationRecord
  validates :name, presence: true, uniqueness: {case_sensitive: false}
  validates :plan, presence: true
  validates_each :plan do |record, attribute, value|
    unless (value === "free") || (value === "moderate") || (value === "unlimited")
      record.errors.add(attribute, "must be valid")
    end
  end

  has_many :members, dependent: :destroy
  has_many :users, through: :members
  has_many :boxes, dependent: :destroy
  has_one :payment_method, dependent: :destroy
  belongs_to :user
  before_destroy :delete_stripe_customer

  def delete_stripe_customer
    Stripe::Customer.delete(stripe_customer_id) if stripe_customer_id
  rescue
  end

  def subscribe(payment_method_params)
    price = Plan.stripe_prices[plan.to_sym]
    customer = StripeRequests.create_customer(user.email, payment_method_params)
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
