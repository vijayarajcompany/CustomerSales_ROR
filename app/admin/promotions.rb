ActiveAdmin.register Promotion do
  permit_params do
    permitted = [:promo_no, :promodescription, :promoitems, :promo_customers, :created_at, :updated_at, :discount_amount, :expirey_date, :customercode, :active_status, :sales_item, :sale_qty, :foc_item, :sale_uom, :foc_qty, :start_date, :end_date, :promotion_type, :discount_value, :value1, :value2, :value3]
    permitted
  end

  action_item :only => :index do
    link_to 'Upload CSV', :action => 'upload_csv'
  end

  collection_action :upload_csv do
    render "file_upload"
  end

  collection_action :import_csv, :method => :post do
    Promotion.load_imported_items(params[:file])
    redirect_to :action => :index, :notice => "CSV imported successfully!"
  end
end
