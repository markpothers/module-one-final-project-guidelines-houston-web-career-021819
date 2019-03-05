class AddCityRefToCity < ActiveRecord::Migration[5.0]
  def change
    add_column :cities, :ref, :TEXT
  end
end
