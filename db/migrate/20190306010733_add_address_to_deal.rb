class AddAddressToDeal < ActiveRecord::Migration[5.0]
  def change
    add_column :deals, :address, :TEXT
  end
end
