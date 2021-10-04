class Api::Xml::V1::ItemMastersController < ActionController::API
  include ApplicationXmlMethods
  skip_before_action :authenticate_request, only: [:create], raise: false

  soap_service namespace: 'urn:WashOut'

  # soap_action "show",
  #   :args   => {:id => :integer},
  #   :return => :xml
  # def show
  #   @item_master = ItemMaster.find(params[:id])
  #   render_success_response({
  #     item_master: single_serializer.new(@item_master, serializer: Api::V1::ItemMasterSerializer).as_json
  #   }, status = 200)
  # end

  # soap_action "index",
  # :args   => {subcategory_id: :integer, brand_ids: [], category_ids: [],max_price: :integer, min_price: :integer, page: :integer, page: :integer},
  # :return => :xml
  # def index
  #   subcategory = Subcategory.find_by_id(params[:subcategory_id])
  #   item_masters = subcategory.item_masters
  #   item_masters = item_masters.where(brand_id: params[:brand_ids]) if params[:brand_ids]
  #   item_masters = item_masters.includes(:item_master_categories).where(item_master_categories: {category_id: params[:category_ids]}) if params[:category_ids]
  #   item_masters = item_masters.where(price: params[:min_price]...params[:max_price]) if params[:min_price].present? && params[:max_price].present?
  #   item_masters = item_masters.page(params[:page]).per(params[:per]).order(sort_by_with_column)
  #   render_success_response({
  #     item_masters: array_serializer.new(item_masters, serializer: Api::V1::ItemMasterSerializer, scope: {current_user: @current_user}).as_json,
  #     category: single_serializer.new(subcategory.category, serializer: Api::V1::CategorySerializer).as_json
  #   },"Item_master Listing", page_meta(item_masters))
  # end

  soap_action "create",
  :args => {:item_master=>{ itemcode: :string, itemdescription: :string, producthierarchy: :string, hierarchydesc: :string, itemgroup: :string, price: :double, unitspercase: :string, activeitem: :string, distchannel: :string, division: :string, excise: :string, vat: :string}},
    :return => {create_response: {:success => :boolean, :message => :string}}
  def create
    item_master = ItemMaster.new(item_master_params)
    if item_master.save
      xml_render_success_response('true', "Created successfully.",'' ,"create_response")
    else
      xml_render_success_response('false', item_master.errors.full_messages.join(', '), '', "create_response")
    end
  end

  def sort_by
    params[:sort_by]
  end

  def sort_column
    params[:column] || 'price'
  end

  def sort_by_with_column
    "#{sort_column} #{sort_by}"
  end
  private

  def item_master_params
    params.require(:item_master).permit(:itemcode, :itemdescription, :producthierarchy, :hierarchydesc, :itemgroup, :price, :unitspercase, :activeitem, :distchannel, :division, :excise, :vat, :quantity, :name, :brand_id)
  end

end
