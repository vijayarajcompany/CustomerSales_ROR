class AddQuantityToSubcategory < ActiveRecord::Migration[5.2]
  def change
    add_column :subcategories, :quantity, :string
  end
end
