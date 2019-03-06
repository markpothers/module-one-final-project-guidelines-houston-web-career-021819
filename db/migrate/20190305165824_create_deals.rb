class CreateDeals < ActiveRecord::Migration[5.0]
  def change
    create_table :deals do | table |
      table.integer :service_id
      table.integer :city_id
      table.text :name
      table.text :description
      table.integer :merchant_id
      table.integer :list_price
      table.integer :deal_price
      table.float :discount
      table.text :url
  end
end
end 
