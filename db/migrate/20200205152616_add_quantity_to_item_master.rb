class AddQuantityToItemMaster < ActiveRecord::Migration[5.2]
  def change
    add_column :item_masters, :quantity, :string
  end
end
