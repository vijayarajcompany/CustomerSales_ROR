module Api
  module V1
    module Users
      class VersionsSerializer < ActiveModel::Serializer
        attributes :id, :item_type, :item_id, :event, :whodunnit, :changeset 
      end
    end
  end
end
