class AddBrandToItemMAster < ActiveRecord::Migration[5.2]
  def change
    add_reference :item_masters, :brand, foreign_key: true
  end
end
