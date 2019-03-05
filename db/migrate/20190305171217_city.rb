class City < ActiveRecord::Migration[5.0]
  def change
    create_table :cities do | table |
      table.text :name
    end 
  end
end
