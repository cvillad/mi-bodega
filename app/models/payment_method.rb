class PaymentMethod < ApplicationRecord
  belongs_to :account

  validates :exp_month, presence: true
  validates :exp_year, presence: true
  validates :brand, presence: true 
  validates :last4, presence: true 
  validates :stripe_id, presence: true

  def self.month_options
    Date::MONTHNAMES.compact.each_with_index.map { |name, i| ["#{i+1} - #{name}", i+1] }
  end

  def self.year_options
    (Date.today.year..(Date.today.year+10)).to_a
  end
end
