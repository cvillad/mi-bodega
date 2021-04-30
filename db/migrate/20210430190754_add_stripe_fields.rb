class AddStripeFields < ActiveRecord::Migration[6.1]
  def change
    add_column :accounts, :stripe_customer_id, :text
  end
end