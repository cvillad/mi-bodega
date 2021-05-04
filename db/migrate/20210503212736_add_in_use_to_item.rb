class AddInUseToItem < ActiveRecord::Migration[6.1]
  def change
    add_reference :items, :using_by, foreign_key: { to_table: :members }
  end
end