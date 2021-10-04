class AddMobileToAddress < ActiveRecord::Migration[5.2]
  def change
    add_column :addresses, :mobile_number, :string
  end
end
