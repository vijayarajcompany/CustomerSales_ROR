module Api
  module V1
    class SubcategoriesSerializer < ActiveModel::Serializer
      attributes :id, :name, :quantity, :image
      belongs_to :category

      def image
        if object.serializer_image.present?
          ActiveModelSerializers::SerializableResource.new(object.serializer_image, serializer: Api::V1::ImageSerializer)
        else
          {}
        end
      end
    end
  end
end
