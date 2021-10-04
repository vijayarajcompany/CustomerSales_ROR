class AddDescriptionToDivision < ActiveRecord::Migration[5.2]
  def change
    add_column :divisions, :description, :string
  end
end
