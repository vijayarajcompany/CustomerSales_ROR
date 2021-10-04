class Product < ApplicationRecord
  searchkick

  belongs_to :category
  belongs_to :brand
  has_many :product_offers

  delegate :name, to: :brand, prefix: true
  delegate :name, to: :category, prefix: true

  def search_data
    {
      brand_name: brand_name,
      category_name: category_name,
      price: price
    }
  end
end
