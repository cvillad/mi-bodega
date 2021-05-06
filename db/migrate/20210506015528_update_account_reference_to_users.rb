class UpdateAccountReferenceToUsers < ActiveRecord::Migration[6.1]
  def change
    remove_reference :users, :current_tenant, foreign_key: { to_table: :accounts }
    add_column :users, :current_tenant_id, :integer
  end
end
