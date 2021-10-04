class Api::V1::DivisionSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :image

  def image
    if object.image.present?
      ActiveModelSerializers::SerializableResource.new(object.image, serializer: Api::V1::ImageSerializer)
    else
      {}
    end
  end
end
