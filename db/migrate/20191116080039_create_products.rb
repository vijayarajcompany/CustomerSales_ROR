class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.references :category
      t.references :brand
      t.string :name
      t.string :sku
      t.decimal :price, precision: 8, scale: 2

      t.timestamps
    end
  end
end
