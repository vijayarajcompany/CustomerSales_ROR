class AddDiscountAmountToPromotion < ActiveRecord::Migration[5.2]
  def change
    add_column :promotions, :discount_amount, :float
  end
end
