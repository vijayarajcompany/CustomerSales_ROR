module Api
  module V1
    class BrandSerializer < ActiveModel::Serializer
      attributes :name, :id
    end
  end
end
