class CreatePromotions < ActiveRecord::Migration[5.2]
  def change
    create_table :promotions do |t|
      t.string :promo_no, null: false
      t.string :promodescription
      t.text :promoitems, array: true, default: []
      t.text :promo_customers, array: true, default: []

      t.timestamps
    end

    add_index :promotions, :promo_no
  end
end
