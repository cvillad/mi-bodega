class BillingController < ApplicationController 
  before_action :set_payment_method, only: [:update]
  def index
    @payment_method = current_tenant.payment_method
    @charges = Stripe::Charge.list({customer: current_tenant.stripe_customer_id})[:data]
    @subscription = Stripe::Subscription.list({customer: current_tenant.stripe_customer_id, limit: 1})[:data].first
  end

  def edit 
    @payment_method = PaymentMethod.new
  end

  def update 
    card = StripeRequests.card_to_client(current_tenant.stripe_customer_id, payment_method_params)
    @payment_method.update(brand: card[:brand], 
      exp_month: card[:exp_month], 
      exp_year: card[:exp_year], 
      stripe_id: card[:id], 
      last4: card[:last4])
    redirect_to billing_path, notice: "Credit card updated successfully"
  rescue => e
    flash.now[:alert] = e.message
    render :edit
  end

  private 
  def set_payment_method
    @payment_method = current_user.account.payment_method
  end

  def payment_method_params 
    params.require(:payment_method).permit(:number, :cvc, :exp_month, :exp_year).to_h
  end
end