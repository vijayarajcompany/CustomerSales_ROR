class CreateItemMasterCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :item_master_categories do |t|
      t.references :item_master
      t.references :category
      t.timestamps
    end
  end
end
