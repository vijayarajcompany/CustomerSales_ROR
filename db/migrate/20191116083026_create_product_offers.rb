class CreateProductOffers < ActiveRecord::Migration[5.2]
  def change
    create_table :product_offers do |t|
      t.references :product
      t.references :offer

      t.timestamps
    end
  end
end
