class Brand < ApplicationRecord
  has_many :products
  has_many :item_masters
end
