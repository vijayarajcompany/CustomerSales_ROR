class AddSourceAmountToOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :source_amount, :float
    add_column :orders, :promotion_amount, :float
  end
end
