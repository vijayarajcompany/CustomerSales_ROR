require 'roo'
require 'csv'
class ItemMaster < ApplicationRecord
  # searchkick
  acts_as_list
  has_many :item_master_categories
  has_many :categories, through: :item_master_categories
  has_many :item_master_subcategories
  has_many :subcategories, through: :item_master_subcategories
  has_many :images, as: :imageable
  has_many :order_items, dependent: :destroy
  belongs_to :brand, optional: true
  accepts_nested_attributes_for :item_master_subcategories, :allow_destroy => true
  accepts_nested_attributes_for :subcategories, :allow_destroy => true
  accepts_nested_attributes_for :item_master_categories, :allow_destroy => true
  accepts_nested_attributes_for :categories, :allow_destroy => true
  accepts_nested_attributes_for :images, :allow_destroy => true
  validates_uniqueness_of :itemcode

  delegate :name, to: :brand, prefix: true

  def search_data
    {
      brand_name: brand_name,
      price: price
    }
  end

  def serializer_images
    if images.present?
      images
    else
      [subcategories.last&.serializer_image].compact
    end
  end

  def self.convert_save(file)
    data = File.read(file.path)
    data = Hash.from_xml(data)
    item_masters = data['MT_ItemMaster']['ItemMaster']

    item_masters.each do |item_master_data|
      create_item_master_data(item_master_data)
    end
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv" then Roo::CSV.new(file.path, nil, :ignore)
    when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
    when ".xlsx" then Roo::Excelx.new(file.path)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end

  def self.load_imported_items(file, uploding_type = "All upload")
    if File.extname(file.original_filename) == ".XML"
      convert_save(file)
    else
      spreadsheet = open_spreadsheet(file)
      header = spreadsheet.row(1)
      if uploding_type == "All upload"
        (2..spreadsheet.last_row).map do |i|
          row = Hash[[header, spreadsheet.row(i)].transpose]
          item = find_by_itemcode(row['ITEMCODE'])
          if item.present?
            update_item_master_data(row.to_hash, item)
          else
            create_item_master_data(row.to_hash)# unless item.present?
          end
        end
      else
        (2..spreadsheet.last_row).map do |i|
          row = Hash[[header, spreadsheet.row(i)].transpose]
          item = find_by_itemcode(row['ITEMCODE'])
          item&.update(price: row['PRICE incl VAT'])
        end
      end
    end
  end

  def self.create_item_master_data(item_master_data)
    if item_master_data['PRODUCTHIERARCHY'].present? && item_master_data['HIERARCHYDESC'].present?
      product = create!(itemcode: item_master_data['ITEMCODE'],
                        itemdescription: item_master_data['ITEMDESCRIPTION'],
                        name: item_master_data['ITEMDESCRIPTION'],
                        producthierarchy: item_master_data['PRODUCTHIERARCHY']&.to_i, # is category
                        hierarchydesc: item_master_data['HIERARCHYDESC'], # is category
                        itemgroup: item_master_data['ITEMGROUP'], # is subcategory
                        price: item_master_data['UNITSPERCASE']&.to_i || 0 * item_master_data['PRICE'].to_f,
                        unitspercase: item_master_data['UNITSPERCASE'].to_i,
                        activeitem: item_master_data['ACTIVEITEM'],
                        distchannel: item_master_data['DISTCHANNEL'],
                        division: item_master_data['DIVISION'],
                        excise: item_master_data['EXCISE'],
                        brand: Brand.last)
      category = Category.find_or_create_by(name: item_master_data['HIERARCHYDESC'].split(' ')[0], division: item_master_data['DIVISION'])
      ItemMasterCategory.find_or_create_by(item_master_id: product.id, category_id: category.id)
      sub_category = Subcategory.find_or_create_by(category_id: category.id, name: item_master_data['ITEMGROUP'])
      ItemMasterSubcategory.find_or_create_by(item_master_id: product.id, subcategory_id: sub_category.id)
    end
  end


  def self.update_item_master_data(item_master_data, item)
    if item_master_data['PRODUCTHIERARCHY'].present? && item_master_data['HIERARCHYDESC'].present?
      product = item.update( itemdescription: item_master_data['ITEMDESCRIPTION'],
                             name: item_master_data['ITEMDESCRIPTION'],
                             producthierarchy: item_master_data['PRODUCTHIERARCHY']&.to_i, # is category
                             hierarchydesc: item_master_data['HIERARCHYDESC'], # is category
                             itemgroup: item_master_data['ITEMGROUP'], # is subcategory
                             price: item_master_data['PRICE']&.round(2),
                             unitspercase: item_master_data['UNITSPERCASE'].to_i,
                             activeitem: item_master_data['ACTIVEITEM'],
                             distchannel: item_master_data['DISTCHANNEL'],
                             division: item_master_data['DIVISION'],
                             excise: item_master_data['EXCISE'],
                             brand: Brand.last)
    end
  end

  def price
    self[:price]&.round(2)
  end
end
