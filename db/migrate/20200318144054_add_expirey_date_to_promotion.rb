class AddExpireyDateToPromotion < ActiveRecord::Migration[5.2]
  def change
    add_column :promotions, :expirey_date, :datetime
  end
end
