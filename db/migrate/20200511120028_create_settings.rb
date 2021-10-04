class CreateSettings < ActiveRecord::Migration[5.2]
  def change
    create_table :settings do |t|
      t.float :minimun_amount
      t.float :shipping_charge
      t.timestamps
    end

    add_column :orders, :shipping_charge, :float
  end
end
