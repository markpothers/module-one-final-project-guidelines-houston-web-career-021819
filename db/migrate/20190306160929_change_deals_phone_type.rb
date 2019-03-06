class ChangeDealsPhoneType < ActiveRecord::Migration[5.0]
  def change
    change_column :deals, :phone, :TEXT
  end
end
