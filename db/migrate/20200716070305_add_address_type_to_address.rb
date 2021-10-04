class AddAddressTypeToAddress < ActiveRecord::Migration[5.2]
  def change
    add_column :addresses, :address_type, :integer, default: 0
  end
end
