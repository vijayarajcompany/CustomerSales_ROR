class ChangeStringToFloatItemMaster < ActiveRecord::Migration[5.2]
  def self.up
    change_column :item_masters, :price, 'float USING CAST(price AS float)'
  end

  def self.down
    change_column :item_masters, :price, :string
  end
end
