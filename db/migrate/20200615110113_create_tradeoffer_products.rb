class CreateTradeofferProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :tradeoffer_products do |t|
      t.string :group_id
      t.string :itemcode
      t.timestamps
    end
  end
end
