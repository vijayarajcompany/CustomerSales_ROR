module Api
  module V1
    class PackSerializer < ActiveModel::Serializer
      attributes  :id, :name, :count, :price, :in_cart?

      def in_cart?
      	if scope && scope[:current_user]
          scope[:current_user].current_order.packs.include? object
        end
      end
    end
  end
end
