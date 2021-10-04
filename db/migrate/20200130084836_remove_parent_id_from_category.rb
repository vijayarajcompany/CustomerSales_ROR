class RemoveParentIdFromCategory < ActiveRecord::Migration[5.2]
  def change
    remove_column :categories, :parent_id, :integer
  end
end
