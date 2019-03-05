class AddPhoneToMerchant < ActiveRecord::Migration[5.0]
  def change
    add_column :merchants, :phone, :INTEGER
  end
end
