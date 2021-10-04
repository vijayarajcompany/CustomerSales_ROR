# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_08_27_110718) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "about_pages", force: :cascade do |t|
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "addresses", force: :cascade do |t|
    t.string "addressable_type"
    t.bigint "addressable_id"
    t.string "title"
    t.text "address"
    t.float "latitude"
    t.float "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "mobile_number"
    t.integer "address_type", default: 0
    t.string "category"
    t.string "alternative_number"
    t.string "alternative_number_country_code"
    t.string "mobile_number_country_code"
    t.index ["addressable_type", "addressable_id"], name: "index_addresses_on_addressable_type_and_addressable_id"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "banners", force: :cascade do |t|
    t.string "avatar"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "brands", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "division"
    t.integer "producthierarchy"
    t.integer "position"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "customer_masters", force: :cascade do |t|
    t.string "customercode", null: false
    t.string "route"
    t.string "customername"
    t.string "address1"
    t.string "address2"
    t.string "address3"
    t.string "city"
    t.string "telephone"
    t.string "paymentterms"
    t.string "creditlimitdays"
    t.string "creditlimitamount"
    t.string "activecustomer"
    t.string "customergroup"
    t.string "vat"
    t.string "excise"
    t.string "tradeoffer_id"
    t.string "volume_cap"
    t.string "outstanding_bill"
    t.string "credit_override"
    t.string "division"
    t.string "credit_limit"
    t.string "credit_exposure"
    t.string "credit_available"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customercode"], name: "index_customer_masters_on_customercode", unique: true
  end

  create_table "customer_price_lists", force: :cascade do |t|
    t.string "customercode", null: false
    t.string "itemcode", null: false
    t.string "startdate"
    t.string "enddate"
    t.string "each_sales_price"
    t.string "carton_sales_price"
    t.string "delimit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customercode"], name: "index_customer_price_lists_on_customercode"
    t.index ["itemcode"], name: "index_customer_price_lists_on_itemcode"
  end

  create_table "divisions", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "description"
  end

  create_table "images", force: :cascade do |t|
    t.string "avatar"
    t.string "imageable_type"
    t.bigint "imageable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["imageable_type", "imageable_id"], name: "index_images_on_imageable_type_and_imageable_id"
  end

  create_table "item_master_categories", force: :cascade do |t|
    t.bigint "item_master_id"
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_item_master_categories_on_category_id"
    t.index ["item_master_id"], name: "index_item_master_categories_on_item_master_id"
  end

  create_table "item_master_subcategories", force: :cascade do |t|
    t.bigint "item_master_id"
    t.bigint "subcategory_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_master_id"], name: "index_item_master_subcategories_on_item_master_id"
    t.index ["subcategory_id"], name: "index_item_master_subcategories_on_subcategory_id"
  end

  create_table "item_masters", force: :cascade do |t|
    t.string "itemcode", null: false
    t.string "itemdescription"
    t.string "producthierarchy"
    t.string "hierarchydesc"
    t.string "itemgroup"
    t.float "price"
    t.string "unitspercase"
    t.string "activeitem"
    t.string "distchannel"
    t.string "division"
    t.string "excise"
    t.string "vat"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "quantity"
    t.string "name"
    t.bigint "brand_id"
    t.integer "position"
    t.index ["brand_id"], name: "index_item_masters_on_brand_id"
    t.index ["itemcode"], name: "index_item_masters_on_itemcode", unique: true
  end

  create_table "offer_items", force: :cascade do |t|
    t.bigint "tradeoffer_id"
    t.integer "group_id"
    t.bigint "customer_master_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_master_id"], name: "index_offer_items_on_customer_master_id"
    t.index ["tradeoffer_id"], name: "index_offer_items_on_tradeoffer_id"
  end

  create_table "offers", force: :cascade do |t|
    t.string "name"
    t.string "type"
    t.integer "rate_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "open_invoices", force: :cascade do |t|
    t.string "customercode", null: false
    t.text "open_invoices", default: [], array: true
    t.string "invoice"
    t.string "inv_date"
    t.string "inv_amount"
    t.string "bal_amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customercode"], name: "index_open_invoices_on_customercode"
  end

  create_table "order_items", force: :cascade do |t|
    t.bigint "order_id"
    t.bigint "item_master_id"
    t.integer "quantity"
    t.integer "pack_size"
    t.float "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "pack_id"
    t.integer "order_item_type", default: 0
    t.integer "trade_offer_id"
    t.integer "offer_by_id"
    t.integer "shopping_type", default: 0
    t.index ["item_master_id"], name: "index_order_items_on_item_master_id"
    t.index ["order_id"], name: "index_order_items_on_order_id"
  end

  create_table "order_promos", force: :cascade do |t|
    t.bigint "order_id"
    t.bigint "promotion_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_promos_on_order_id"
    t.index ["promotion_id"], name: "index_order_promos_on_promotion_id"
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "user_id"
    t.float "total_amount"
    t.string "order_number"
    t.integer "status", default: 0
    t.text "shipping_address"
    t.bigint "promotion_id"
    t.float "extra_charges"
    t.float "order_item_amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "source_amount"
    t.float "promotion_amount"
    t.integer "order_payment_type"
    t.text "sap_errors"
    t.float "shipping_charge"
    t.float "vat_charge", default: 0.0
    t.datetime "place_order_date"
    t.integer "shopping_type", default: 0
    t.integer "trade_offer_id"
    t.index ["promotion_id"], name: "index_orders_on_promotion_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "packs", force: :cascade do |t|
    t.string "name"
    t.integer "count"
    t.string "packable_type"
    t.bigint "packable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["packable_type", "packable_id"], name: "index_packs_on_packable_type_and_packable_id"
  end

  create_table "product_offers", force: :cascade do |t|
    t.bigint "product_id"
    t.bigint "offer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["offer_id"], name: "index_product_offers_on_offer_id"
    t.index ["product_id"], name: "index_product_offers_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.bigint "category_id"
    t.bigint "brand_id"
    t.string "name"
    t.string "sku"
    t.decimal "price", precision: 8, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "position"
    t.index ["brand_id"], name: "index_products_on_brand_id"
    t.index ["category_id"], name: "index_products_on_category_id"
  end

  create_table "promo_customers", force: :cascade do |t|
    t.bigint "customer_id"
    t.bigint "promotion_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_promo_customers_on_customer_id"
    t.index ["promotion_id"], name: "index_promo_customers_on_promotion_id"
  end

  create_table "promoitems", force: :cascade do |t|
    t.bigint "customer_master_id"
    t.bigint "promotion_id"
    t.string "sales_item"
    t.string "sale_qty"
    t.string "sale_uom"
    t.string "foc_item"
    t.string "foc_qty"
    t.string "add_2"
    t.string "add_3"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_master_id"], name: "index_promoitems_on_customer_master_id"
    t.index ["promotion_id"], name: "index_promoitems_on_promotion_id"
  end

  create_table "promotions", force: :cascade do |t|
    t.string "promo_no", null: false
    t.string "promodescription"
    t.text "promoitems", default: [], array: true
    t.text "promo_customers", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "discount_amount"
    t.datetime "expirey_date"
    t.string "customercode"
    t.boolean "active_status"
    t.string "sales_item"
    t.string "sale_qty"
    t.string "foc_item"
    t.string "sale_uom"
    t.string "foc_qty"
    t.string "start_date"
    t.string "end_date"
    t.string "promotion_type"
    t.string "discount_value"
    t.string "value1"
    t.string "value2"
    t.string "value3"
    t.index ["promo_no"], name: "index_promotions_on_promo_no"
  end

  create_table "saleorder_statuses", force: :cascade do |t|
    t.string "sale_orderid", null: false
    t.string "target"
    t.string "order_status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sale_orderid"], name: "index_saleorder_statuses_on_sale_orderid"
  end

  create_table "saleorders", force: :cascade do |t|
    t.string "customercode", limit: 10, null: false
    t.string "sales_org", limit: 4, null: false
    t.string "distr_chain", limit: 4, null: false
    t.string "division", limit: 4, null: false
    t.datetime "deliverydate", null: false
    t.string "source"
    t.string "lpo"
    t.string "createdby", limit: 10
    t.string "sender"
    t.text "products", default: [], array: true
    t.string "itemcode", limit: 18, null: false
    t.decimal "quantity", null: false
    t.string "offer_flag", limit: 1
    t.string "promoid", limit: 10
    t.string "offerid", limit: 10
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customercode"], name: "index_saleorders_on_customercode"
  end

  create_table "settings", force: :cascade do |t|
    t.float "minimun_amount"
    t.float "shipping_charge"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "vat_charge", default: 0.0
  end

  create_table "subcategories", force: :cascade do |t|
    t.string "name"
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "promotion_id"
    t.bigint "trade_offer_id"
    t.string "quantity"
    t.integer "position"
    t.index ["category_id"], name: "index_subcategories_on_category_id"
    t.index ["promotion_id"], name: "index_subcategories_on_promotion_id"
    t.index ["trade_offer_id"], name: "index_subcategories_on_trade_offer_id"
  end

  create_table "trade_offer_categories", force: :cascade do |t|
    t.bigint "trade_offer_id"
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_trade_offer_categories_on_category_id"
    t.index ["trade_offer_id"], name: "index_trade_offer_categories_on_trade_offer_id"
  end

  create_table "trade_offers", force: :cascade do |t|
    t.string "tradeoffer_id"
    t.string "tradeitem", null: false
    t.string "startdate"
    t.string "enddate"
    t.string "trade_offer_type"
    t.string "status"
    t.string "qualif_id"
    t.string "qualif_desc"
    t.string "sales_qty"
    t.string "flex_grp"
    t.string "flex_desc"
    t.string "foc_qty"
    t.text "offer_items", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.string "itemcode"
    t.index ["tradeitem"], name: "index_trade_offers_on_tradeitem"
    t.index ["tradeoffer_id"], name: "index_trade_offers_on_tradeoffer_id"
  end

  create_table "tradeoffer_products", force: :cascade do |t|
    t.string "group_id"
    t.string "itemcode"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_trade_offers", force: :cascade do |t|
    t.bigint "trade_offer_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["trade_offer_id"], name: "index_user_trade_offers_on_trade_offer_id"
    t.index ["user_id"], name: "index_user_trade_offers_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email", null: false
    t.string "password_digest"
    t.bigint "company_id"
    t.boolean "activated", default: false
    t.string "confirm_token"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.string "ern_number"
    t.json "document"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "last_login"
    t.string "profile_picture"
    t.string "customercode"
    t.string "route"
    t.string "address1"
    t.string "city"
    t.string "telephone"
    t.string "paymentterms"
    t.string "creditlimitdays"
    t.string "creditlimitamount"
    t.string "activecustomer"
    t.string "customergroup"
    t.string "vat"
    t.string "excise"
    t.string "tradeoffer_id"
    t.string "credit_override"
    t.string "division"
    t.boolean "confirm"
    t.integer "user_type", default: 0
    t.index ["company_id"], name: "index_users_on_company_id"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.integer "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at"
    t.text "object_changes"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  create_table "wallets", force: :cascade do |t|
    t.float "current_credit_limit"
    t.float "outstanding_credit_limit"
    t.float "pending_credit_limit"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_wallets_on_user_id"
  end

  add_foreign_key "item_masters", "brands"
  add_foreign_key "order_items", "item_masters"
  add_foreign_key "order_items", "orders"
  add_foreign_key "orders", "users"
  add_foreign_key "subcategories", "categories"
  add_foreign_key "subcategories", "promotions"
  add_foreign_key "subcategories", "trade_offers"
  add_foreign_key "wallets", "users"
end
