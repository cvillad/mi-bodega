class Plan
  PLANS = [:free, :moderate,:inlimited]

  def self.options
    PLANS.map {|plan| [plan.capitalize, plan]}
  end
end