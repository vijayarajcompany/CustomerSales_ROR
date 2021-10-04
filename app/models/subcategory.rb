class Subcategory < ApplicationRecord
  acts_as_list
  default_scope  { order(position: :asc) }
  belongs_to :category
  belongs_to :promotion, optional: true
  belongs_to :trade_offer, optional: true
  has_many :item_master_subcategories
  has_many :item_masters, through: :item_master_subcategories
  has_one :image, as: :imageable
  accepts_nested_attributes_for :image, :allow_destroy => true

  def serializer_image
    if image.present?
      image
    else
      category.image
    end

  end
end
