class AddPositionToCategory < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :position, :integer
    Category.order(:updated_at).each.with_index(1) do |todo_item, index|
      todo_item.update_column :position, index
    end
    add_column :subcategories, :position, :integer
    Subcategory.order(:updated_at).each.with_index(1) do |todo_item, index|
      todo_item.update_column :position, index
    end
    add_column :products, :position, :integer
    Product.order(:updated_at).each.with_index(1) do |todo_item, index|
      todo_item.update_column :position, index
    end
    add_column :item_masters, :position, :integer
    ItemMaster.order(:updated_at).each.with_index(1) do |todo_item, index|
      todo_item.update_column :position, index
    end
  end
end
