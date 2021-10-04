class CreateItemMasterSubcategories < ActiveRecord::Migration[5.2]
  def change
    create_table :item_master_subcategories do |t|
      t.references :item_master
      t.references :subcategory
      t.timestamps
    end
  end
end
