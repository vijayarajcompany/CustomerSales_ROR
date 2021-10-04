class CreateItemMasters < ActiveRecord::Migration[5.2]
  def change
    create_table :item_masters do |t|
      t.string :itemcode, null: false
      t.string :itemdescription
      t.string :producthierarchy
      t.string :hierarchydesc
      t.string :itemgroup
      t.string :price
      t.string :unitspercase
      t.string :activeitem
      t.string :distchannel
      t.string :division
      t.string :excise
      t.string :vat

      t.timestamps
    end

    add_index :item_masters, :itemcode, unique: true
  end
end

