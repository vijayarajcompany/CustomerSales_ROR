module Api
  module Xml
    module V1
    class ProductsController < Api::V1::ApiController
      skip_before_action :authenticate_request, only: [:search], raise: false

      soap_service namespace: 'urn:WashOut'

      soap_action "search",
      :args => {:query=> :string, :brand_name => :string, :category_name => :string},
      :return => :xml
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
          user: array_serializer.new(outcome.results, serializer: ProductSerializer).as_json
        }, status = 200)
      end
    end
    end
  end
end

