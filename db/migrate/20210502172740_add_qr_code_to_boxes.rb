class AddQrCodeToBoxes < ActiveRecord::Migration[6.1]
  def change
    add_column :boxes, :qr_code, :text
  end
end
