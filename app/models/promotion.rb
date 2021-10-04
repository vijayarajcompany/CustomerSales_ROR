class Promotion < ApplicationRecord
  has_many :promoitems
  has_many :promo_customers
  has_many :subcategories
  validates_uniqueness_of :promo_no
  has_many :customers, through: :promo_customers

  def name
    promo_no
  end

  def can_use_coupon?(user)
    promo_customers.where(customer_id: user.id).any?
  end

  def self.convert_save(file)
    data = File.read(file.path)
    data = Hash.from_xml(data)

    promotions = data["MT_Promotions"]['Promotions']
    promotions.each do |promotion|
      obj = create(promo_no: promotions['PROMO_NO'], promodescription: promotions['PROMODESCRIPTION'])
      promo = find_by_promo_no(promotions['PROMO_NO'])

      promotions['PROMOITEMS'].each do |promoitem|
         Promoitem.create!(sales_item: promoitem['SALES_ITEM'], sale_qty: promoitem['SALE_QTY'], sale_uom: promoitem['SALE_UOM'], foc_item: promoitem['FOC_ITEM'], foc_qty: promoitem['FOC_QTY'], promotion_id: promo.id)
      end
      promotions["PROMO_CUSTOMERS"].each do |pc|
        user = User.find_by_ern_number(pc['CUSTOMERCODE'])
        if  user
          promo.promo_customers.create(customer: User.find_by_ern_number(pc['CUSTOMERCODE']))
        end
      end
    end
  end

  def self.load_imported_items(file)
    if File.extname(file.original_filename) == ".XML"
      convert_save(file)
    else
      spreadsheet = open_spreadsheet(file)
      header = spreadsheet.row(1)
      (2..spreadsheet.last_row).map do |i|
        row = Hash[[header, spreadsheet.row(i)].transpose]
        item = find_by_itemcode(row['ITEMCODE'])
        create_item_master_data(row.to_hash) unless item.present?
      end
    end
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv" then Csv.new(file.path, nil, :ignore)
    when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
    when ".xlsx" then Roo::Excelx.new(file.path)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end
end
