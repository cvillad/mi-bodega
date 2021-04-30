class Plan
  PLANS = [:free, :moderate, :unlimited]
  STRIPE_PRICES = { moderate: "price_1Im3P6DkFrEJHyshL8bRJ18c", unlimited: "price_1Im3PNDkFrEJHyshDVHM9EFh" }
  PRICES = { moderate: 500, unlimited: 1000 }

  def self.stripe_prices 
    STRIPE_PRICES
  end

  def self.options
    PLANS.map {|plan| [plan.capitalize, plan]}
  end
end