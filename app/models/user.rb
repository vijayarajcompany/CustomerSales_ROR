class User < ApplicationRecord
  include Authenticatable

  enum status: [ :not_verified, :verified ]
  enum user_type: [ "home_delivery", "business_customer" ]
  attr_accessor :erp_number

  validates :first_name, presence: true
  # validates_uniqueness_of :ern_number
  mount_uploader :document, AvatarUploader
  mount_uploader :profile_picture, AvatarUploader
  has_many :user_trade_offers, dependent: :destroy
  has_many :trade_offers, through: :user_trade_offers
  has_one :wallet, dependent: :destroy

  has_many :orders, dependent: :destroy
  has_many :addresses, as: :addressable, dependent: :destroy
  has_many :promo_customers, foreign_key: "customer_id", dependent: :destroy
  # has_many :promotions, through: :promo_customer
  #before_create :confirmation_tokent-
  after_create :set_wallet!#, :registration_confirmation_mail!

  validate :uniqueness_of_ern_number, on: :create

  before_save :send_notification_after_activated

  def send_notification_after_activated
    return if home_delivery?
    UserMailer.activated(self).deliver_now if (self.activated_changed? && self.activated == true)
  end

  def uniqueness_of_ern_number
    return unless ern_number.present?
    if User.where(ern_number: ern_number).any?
      errors.add(:erp_number, 'is already used.')
    end
  end

  def set_wallet!
    create_wallet(current_credit_limit: 0, outstanding_credit_limit: 0, pending_credit_limit: 0)
  end

  def promotions
    Promotion.where(id: promo_customers.pluck(:promotion_id))
  end

  def send_confirmation_mail!
    if home_delivery?
      self.update_columns(ern_number: ErpAssignment.last.erp_number)
    end
    confirmation_token
    registration_confirmation_mail!
  end

  def created_by_sap
   "#{id}|#{first_name}|#{last_name}|#{email}"
  end

  def registration_confirmation_mail!
    UserMailer.registration_confirmation(self).deliver_now
  end

  def send_password_reset_email
    UserMailer.password_reset(self, reset_token).deliver_now
  end

  def send_password_changed_email
    UserMailer.password_changed(self).deliver_now
  end

  def send_registration_confirmation(invited_feature=nil)
    UserMailer.registration_confirmation(user, invited_feature).deliver_now
  rescue StandardError
    false
  end

  def confirm!
    assign_attributes(confirm: true, confirm_token: nil)
    save(validate: false)
    update_columns(activated: true)
    # UserMailer.after_confirmation(self).deliver_now
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def current_order
    orders.processing.first || orders.create()
  end

  def cart_item_count
    current_order.order_items.count.to_s
  end

  def self.convert_save(file)
    data = File.read(file.path)
    data = Hash.from_xml(data)
    users = data["MT_CustomerMaster"]['CustomerMaster']
    users.each do |user|
      create_user_data(user)
    end
  end

  def self.create_user_data(user)
    if !find_by(customercode: user['CUSTOMERCODE'].to_s)
      obj = create!(customercode: user['CUSTOMERCODE'].to_s,
                    ern_number: user['CUSTOMERCODE'].to_s,
                    route: user['ROUTE'],
                    address1: user['ADDRESS1'],
                    city: user['CITY'],
                    telephone: user['TELEPHONE'],
                    paymentterms: user['PAYMENTTERMS'],
                    creditlimitdays: user['CREDITLIMITDAYS'],
                    creditlimitamount: user['CREDITLIMITAMOUNT'],
                    activecustomer: user['ACTIVECUSTOMER'],
                    customergroup: user['CUSTOMERGROUP'],
                    vat: user["VAT"],
                    excise: user['EXCISE'],
                    tradeoffer_id: user["TRADEOFFER_ID"],
                    credit_override: user['CREDIT_OVERRIDE'],
                    division: user['DIVISION'],
                    email: user['CUSTOMERCODE'].to_s + "@pepsidrc.com",
                    password: user['CUSTOMERCODE'].to_s + "pepsidrc",
                    password_confirmation: user['CUSTOMERCODE'].to_s + "pepsidrc",
                    first_name: user['CUSTOMERCODE'].to_s)
      trade_offer = TradeOffer.find_by_id(user["TRADEOFFER_ID"])
      UserTradeOffer.create(trade_offer: trade_offer, user: obj)
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

  def self.load_imported_items(file)
    if File.extname(file.original_filename) == ".XML"
      convert_save(file)
    else
      spreadsheet = open_spreadsheet(file)
      header = spreadsheet.row(1)
      (2..spreadsheet.last_row).map do |i|
        row = Hash[[header, spreadsheet.row(i)].transpose]
        item = find_by_ern_number(row['CUSTOMERCODE'])
        create_user_data(row.to_hash) unless item.present?
      end
    end
  end

  #before_save :udpate_after_division
  def udpate_after_division
    if division_changed?
      current_order.order_items.destroy_all
    end
  end

  private

  def confirmation_token
    if self.confirm_token.blank?
      self.confirm_token = generate_token
      self.save
    end
  end
end
