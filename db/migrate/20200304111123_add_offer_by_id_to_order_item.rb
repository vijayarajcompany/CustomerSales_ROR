class AddOfferByIdToOrderItem < ActiveRecord::Migration[5.2]
  def change
    add_column :order_items, :offer_by_id, :integer
  end
end
