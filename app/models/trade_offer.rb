class TradeOffer < ApplicationRecord
  has_many :user_trade_offers
  has_many :trade_offer_categories
  has_many :categories, through: :trade_offer_categories
  has_many :user_trade_offers
  has_many :users, through: :user_trade_offers

  def name
    title
  end

  def self.convert_save(file)
    data = File.read(file.path)
    data = Hash.from_xml(data)
    trade_offers = data['MT_TradeOffers']["TradeOffers"]
    trade_offers.each do |trade_offer|
      self.create_trade_data(trade_offer)
    end
  end

  def self.create_trade_data(trade_offer)
    trade = create(
      tradeoffer_id: trade_offer['TRADEOFFER_ID'],
      tradeitem: trade_offer['TRADE_ITEM'],
      startdate: trade_offer['START_DATE'],
      enddate: trade_offer['END_DATE'],
      trade_offer_type:trade_offer['TRADE_OFFER_TYPE'],
      status: trade_offer[''],
      qualif_id: trade_offer['QUALIF_ID'],
      qualif_desc: trade_offer['QUALIF_DESC'],
      sales_qty: trade_offer['SALES_QTY'],
      flex_grp: trade_offer['FLEX_GRP'],
      flex_desc: trade_offer['FLEX_DESC'],
      foc_qty: trade_offer['FOC_QTY']
    )

    category = Category.find_by(name: trade_offer['QUALIF_DESC'].split(' ')[0])
    ItemMasterCategory.find_or_create_by(trade_offer_id: trade.id, category_id: category.id)
    trade_offer['QUALIF_DESC']
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv" then Csv.new(file.path, nil, :ignore)
    when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
    when ".xlsx" then Roo::Excelx.new(file.path)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end

  def self.load_imported_items(file)
    if File.extname(file.original_filename) == ".XML"
      convert_save(file)
    else
      spreadsheet = open_spreadsheet(file)
      header = spreadsheet.row(1)
      (5..spreadsheet.last_row).map do |i|
        row = Hash[[header, spreadsheet.row(i)].transpose]
        item = find_by_itemcode(row['TRADEOFFER_ID'])
        create_item_master_data(row.to_hash) unless item.present?
      end
    end
  end
end
