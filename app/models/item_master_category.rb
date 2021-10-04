class ItemMasterCategory < ApplicationRecord
  belongs_to :item_master
  belongs_to :category 
end
