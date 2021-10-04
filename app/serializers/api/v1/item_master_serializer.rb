module Api
  module V1
    class ItemMasterSerializer < ActiveModel::Serializer
      attributes  :id, :name, :itemcode, :itemdescription, :producthierarchy, :hierarchydesc, :itemgroup, :price, :quantity, :unitspercase, :activeitem, :distchannel, :division, :excise, :vat, :in_cart?, :images, :cart_object_type

      # def packs
      #   ActiveModel::Serializer::CollectionSerializer.new(object.packs.order(:count), serializer: Api::V1::PackSerializer, scope: {current_user: scope&.dig(:current_user)}).as_json
      # end

      def in_cart?
        if scope && scope[:current_user]
          if scope[:trade_offer_id]
            current_order.order_items.where(trade_offer_id: scope[:trade_offer_id]).map(&:item_master).include? object
          else
            current_order.item_masters.include? object
          end
        else
          false
        end
      end

      def cart_object_type
        if scope && scope[:current_user]
          scope[:current_user].current_order.as_json(only: [:trade_offer_id, :shopping_type])
        else
          {}
        end
      end

      def images
        ActiveModel::Serializer::CollectionSerializer.new(object.serializer_images, serializer: Api::V1::ImageSerializer)
      end

      def current_order
        scope[:current_user].current_order
      end
    end
  end
end
