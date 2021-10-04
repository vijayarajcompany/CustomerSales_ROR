module Api
  module V1
    class ProductSerializer < ActiveModel::Serializer
      attributes :category_id, :category_name, :brand_id, :brand_name,
                 :name, :sku, :price

      def price
        object.price.to_f
      end
    end
  end
end
