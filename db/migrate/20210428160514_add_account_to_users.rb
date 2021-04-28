class AddAccountToUsers < ActiveRecord::Migration[6.1]
  def up
    add_column :users, :account_id, :integer
    add_index  :users, :account_id
  end
end
