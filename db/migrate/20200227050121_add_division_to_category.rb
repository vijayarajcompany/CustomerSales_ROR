class AddDivisionToCategory < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :division, :string
    add_column :categories, :producthierarchy, :integer
  end
end
