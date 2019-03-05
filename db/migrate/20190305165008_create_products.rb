class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do | table|
      table.text :name
      table.text :description
      table.text :service
    end 
  end
end
