module Api
  module V1
    class OrderItemSerializer < ActiveModel::Serializer
      attributes :id, :quantity, :pack_size, :amount, :item_master, :order_item_type, :total_amount, :shopping_type, :status

      def item_master
        if object.item_master
          ActiveModelSerializers::SerializableResource.new(object.item_master, serializer: Api::V1::ItemMasterSerializer)
        else
          {}
        end
      end
    end
  end
end
