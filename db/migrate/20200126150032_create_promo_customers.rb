class CreatePromoCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :promo_customers do |t|
      t.references :customer
      t.references :promotion
      t.timestamps
    end
  end
end
