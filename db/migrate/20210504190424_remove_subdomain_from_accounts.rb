class RemoveSubdomainFromAccounts < ActiveRecord::Migration[6.1]
  def change
    remove_column :accounts, :subdomain
  end
end
