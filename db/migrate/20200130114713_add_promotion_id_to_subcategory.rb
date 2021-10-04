class AddPromotionIdToSubcategory < ActiveRecord::Migration[5.2]
  def change
    add_reference :subcategories, :promotion, foreign_key: true
  end
end
