class CreateServices < ActiveRecord::Migration[5.0]
  def change
    create_table :services do |table|
      table.text :service
    end 
  end
end
