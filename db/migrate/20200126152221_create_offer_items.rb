class CreateOfferItems < ActiveRecord::Migration[5.2]
  def change
    create_table :offer_items do |t|
      t.references :tradeoffer
      t.integer :group_id
      t.references :customer_master
      t.timestamps
    end
  end
end
