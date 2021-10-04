class Category < ApplicationRecord
  default_scope  { order(position: :asc) }
  acts_as_list
  has_many :products
  has_many :item_master_categories
  has_many :item_masters, through: :item_master_categories
  has_one :image, as: :imageable
  accepts_nested_attributes_for :image, :allow_destroy => true
  has_many :subcategories, dependent: :delete_all
end
