class PaymentMethod < ApplicationRecord
  belongs_to :account
  attr_accessor :number, :cvc, :exp_month, :exp_year

  def self.month_options
    Date::MONTHNAMES.compact.each_with_index.map { |name, i| ["#{i+1} - #{name}", i+1] }
  end

  def self.year_options
    (Date.today.year..(Date.today.year+10)).to_a
  end
end
