class AddCurrentTenantToUsers < ActiveRecord::Migration[6.1]
  def change
    add_reference :users, :current_tenant, foreign_key: { to_table: :accounts }
  end
end
