class RemoveMemberReferenceFromBox < ActiveRecord::Migration[6.1]
  def change
    remove_reference :boxes, :member, index: true
  end
end
