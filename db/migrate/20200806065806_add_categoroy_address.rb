class AddCategoroyAddress < ActiveRecord::Migration[5.2]
  def change
    add_column :addresses, :category, :string
  end
end
