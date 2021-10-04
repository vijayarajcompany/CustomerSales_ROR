class AddSapErrorToOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :sap_errors, :text
  end
end
