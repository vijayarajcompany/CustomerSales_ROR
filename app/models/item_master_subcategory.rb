class ItemMasterSubcategory < ApplicationRecord
  belongs_to :item_master
  belongs_to :subcategory
end
