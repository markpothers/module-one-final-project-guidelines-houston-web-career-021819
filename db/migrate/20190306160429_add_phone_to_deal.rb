class AddPhoneToDeal < ActiveRecord::Migration[5.0]
  def change
    add_column :deals, :phone, :integer
  end
end
