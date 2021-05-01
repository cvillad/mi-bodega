class BillingController < ApplicationController 
  def index
    @payment_method = current_tenant.payment_method
    @charges = Stripe::Invoice.list({customer: current_tenant.stripe_customer_id})[:data]
  end
end