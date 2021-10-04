class Api::V1::ItemMastersController < Api::V1::ApiController
  before_action :authenticate_request
  skip_before_action :authenticate_request, only: [:search]

  def show
    item_master = ItemMaster.find(params[:id])
    render_success_response({
                              item_master: single_serializer.new(item_master, serializer: Api::V1::ItemMasterSerializer, scope: {current_user: current_user, trade_offer_id: params[:trade_offer_id]})
    })
  end

  def search_item_master
    item_masters = ItemMaster.where(name: params[:name]) if params[:name]
    item_masters = ItemMaster.where(itemdescription: params[:itemdescription]) if params[:itemdescription]
    render_success_response({
                              item_master: array_serializer.new(item_masters, serializer: Api::V1::ItemMasterSerializer)
    })
  end

  def index
    keyword = params[:search]
    subcategory = Subcategory.find_by_id(params[:subcategory_id])
    item_masters = subcategory.item_masters
    item_masters = item_masters.where("name LIKE ? OR itemdescription LIKE ?", "%#{keyword}%", "%#{keyword}%") if keyword
    item_masters = item_masters.where(brand_id: params[:brand_ids]) if params[:brand_ids]
    item_masters = item_masters.includes(:item_master_categories).where(item_master_categories: {category_id: params[:category_ids]}) if params[:category_ids]
    item_masters = item_masters.where(price: params[:min_price]...params[:max_price]) if params[:min_price].present? && params[:max_price].present?
    item_masters = item_masters.page(params[:page]).per(params[:per] || 100).order(sort_by_with_column)
    render_success_response({
                              item_masters: array_serializer.new(item_masters, serializer: Api::V1::ItemMasterSerializer, scope: {current_user: current_user, trade_offer_id: params[:trade_offer_id]}),
                              category: single_serializer.new(subcategory.category, serializer: Api::V1::CategorySerializer),
                              cart_object_type: order_detail
    },"Item_master Listing", page_meta(item_masters))
  end

  def search
    auth = AuthorizeApiRequest.call(request.headers)
    current_user = auth.result

    keyword = params[:search]

    if params[:subcategory_id]
      item_masters = ItemMaster.joins(:item_master_subcategories).where(item_master_subcategories: {subcategory_id: params[:subcategory_id]})
    else
      item_masters = ItemMaster.all
    end

    item_masters = item_masters.where("lower(name) LIKE lower(?) OR lower(itemdescription) LIKE lower(?)", "%#{keyword}%", "%#{keyword}%") if keyword
    item_masters = item_masters.where(brand_id: params[:brand_ids]) if params[:brand_ids]
    item_masters = item_masters.includes(:item_master_categories).where(item_master_categories: {category_id: params[:category_ids]}) if params[:category_ids]
    item_masters = item_masters.where(price: params[:min_price]...params[:max_price]) if params[:min_price].present? && params[:max_price].present?
    item_masters = item_masters.page(params[:page]).per(params[:per]).order(sort_by_with_column)
    render_success_response({
                              item_masters: array_serializer.new(item_masters, serializer: Api::V1::ItemMasterSerializer, scope: {current_user: current_user, trade_offer_id: params[:trade_offer_id]}),
                              cart_object_type: order_detail
    },"Item_master Listing", page_meta(item_masters))
  end

  def sort_column
    params[:column] || 'position'
  end

  def sort_by_with_column
    "#{sort_column} #{sort_by}"
  end

  def order_detail
    current_user&.current_order&.as_json(only: [:trade_offer_id, :shopping_type])
  end
end
