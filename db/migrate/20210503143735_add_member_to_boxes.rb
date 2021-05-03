class AddMemberToBoxes < ActiveRecord::Migration[6.1]
  def change
    add_reference :boxes, :member, index: true
  end
end
