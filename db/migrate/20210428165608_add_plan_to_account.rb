class AddPlanToAccount < ActiveRecord::Migration[6.1]
  def change
    add_column :accounts, :plan, :string
  end
end
