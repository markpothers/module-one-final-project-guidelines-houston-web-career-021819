class RemovePhoneFromMerchant < ActiveRecord::Migration[5.0]
  def change
    remove_column :merchants, :phone
  end
end
