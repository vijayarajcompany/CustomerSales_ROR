class Api::V1::AboutPageSerializer < ActiveModel::Serializer
  attributes :id, :content
  has_many :images
end
