class BillingController < ApplicationController 
  def index
    @payment_method = current_tenant.payment_method
    @charges = Stripe::Charge.list({customer: current_tenant.stripe_customer_id})[:data]
    @subscription = Stripe::Subscription.list({customer: current_tenant.stripe_customer_id, limit: 1})[:data].first
  end
end