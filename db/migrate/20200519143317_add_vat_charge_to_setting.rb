class AddVatChargeToSetting < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :vat_charge, :float, default: 0
    add_column :settings, :vat_charge, :float, default: 0
  end
end
