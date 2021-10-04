ActiveAdmin.register Order do

  show do
    attributes_table do
      ["id", "user_id", "total_amount", "order_number", "status", "shipping_address", "promotion_id", "extra_charges", "order_item_amount", "created_at", "updated_at", "source_amount", "promotion_amount", "order_payment_type", "sap_errors", "title", "address", "latitude", "longitude", "created_at", "updated_at", "mobile_number", "address_type", "category", "alternative_number", "alternative_number_country_code", "mobile_number_country_code"].each do |order_field|
        row order_field.to_sym
      end

      panel "Table of Contents" do
        table_for order.address do
          ["id", "addressable_type", "addressable_id", "title", "address", "latitude", "longitude", "created_at", "updated_at", "mobile_number", "address_type", "category", "alternative_number", "alternative_number_country_code", "mobile_number_country_code"].each do |a|
            column a.to_sym
          end
        end
      end

    end

    active_admin_comments
  end

  csv do
    ["id", "user_id", "total_amount", "order_number", "status", "shipping_address", "promotion_id", "extra_charges", "order_item_amount", "created_at", "updated_at", "source_amount", "promotion_amount", "order_payment_type", "sap_errors"].map do |order_field|
      column order_field.to_sym
    end
    column(:title) { |post| post.title }
    column(:latitude) { |post| post.latitude }
    column(:longitude) { |post| post.longitude }

    column(:mobile_number) { |post| post.mobile_number }
    column(:address_type) { |post| post.address_type }
    column(:category) { |post| post.category }
    column(:alternative_number_country_code) { |post| post.alternative_number_country_code }
    column(:alternative_number) { |post| post.alternative_number }
    column(:mobile_number_country_code) { |post| post.mobile_number_country_code }
    column(:place_order_date) { |post| post.place_order_date }


  end

  index do
    selectable_column
    ["id", "user_id", "total_amount", "order_number", "status", "shipping_address", "promotion_id", "extra_charges", "order_item_amount", "created_at", "updated_at", "source_amount", "promotion_amount", "order_payment_type", "sap_errors", "title", "latitude", "longitude", "created_at", "updated_at", "mobile_number", "address_type", "category", "alternative_number", "alternative_number_country_code", "mobile_number_country_code", "place_order_date"].each do |order_field|
      column order_field.to_sym
    end
    actions
  end

  permit_params do
    permitted = [:user_id, :total_amount, :order_number, :status, :shipping_address, :promotion_id, :extra_charges, :order_item_amount, :created_at, :updated_at, :source_amount, :promotion_amount, :order_payment_type, :sap_errors, :title, :latitude, :longitude, :created_at, :updated_at, :mobile_number, :address_type, :category, :alternative_number, :alternative_number_country_code, :mobile_number_country_code, :place_order_date]
  end
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params
  #
  # or
  #
  # permit_params do
  #   permitted = [:user_id, :total_amount, :order_number, :status, :shipping_address, :promotion_id, :extra_charges, :order_item_amount, :source_amount, :promotion_amount]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

end
