module Api
  module V1
    class ProductsController < Api::V1::ApiController
      skip_before_action :authenticate_request, only: [:search, :index, :show]

      def search
        search = params[:query] || "*"
        conditions = {}
        conditions[:brand_name] = params[:brand_name] if params[:brand_name].present?
        conditions[:category_name] = params[:category_name] if params[:category_name].present?
        
        if params[:lte].present? && params[:gte].present?
          conditions[:price] = {gte: params[:gte], lte: params[:lte]}
        end

        outcome = Product.search search, where: conditions

        render_success_response({
          user: array_serializer.new(outcome.results, serializer: ProductSerializer)
        }, status = 200)
      end
    end
  end
end

