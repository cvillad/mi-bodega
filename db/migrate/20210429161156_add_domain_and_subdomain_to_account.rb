class AddDomainAndSubdomainToAccount < ActiveRecord::Migration[6.1]
  def change
    add_column :accounts, :subdomain, :string
  end
end
