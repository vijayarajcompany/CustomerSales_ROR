module Api
  module V1
    class CategorySerializer < ActiveModel::Serializer
      attributes :id, :name, :division, :item_masters
      has_many :image

      def item_masters
        ActiveModel::Serializer::CollectionSerializer.new(object.item_masters, serializer: Api::V1::ItemMasterSerializer)
      end
    end
  end
end
