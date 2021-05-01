class CreatePaymentMethods < ActiveRecord::Migration[6.1]
  def change
    create_table :payment_methods do |t|
      t.string :brand
      t.string :exp_month
      t.string :exp_year
      t.string :last4
      t.string :stripe_id
      t.belongs_to :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
