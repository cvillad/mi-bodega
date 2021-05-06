class StripeRequests 
  def self.create_customer(email, payment_method_params) 
    token = Stripe::Token::create({card: payment_method_params})[:id]
    Stripe::Customer.create email: email, source: token
  end

  def self.card_to_client(client, payment_method_params)
    token = Stripe::Token.create(card: payment_method_params)[:id]
    customer = Stripe::Customer.update(client, source: token)
    Stripe::Customer.list_sources(customer[:id])[:data].first
  end
  
end