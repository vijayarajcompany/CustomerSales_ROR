ActiveAdmin.register TradeOffer do

  action_item :only => :index do
    link_to 'Upload CSV', :action => 'upload_csv'
  end

  collection_action :upload_csv do
    render "file_upload"
  end

  collection_action :import_csv, :method => :post do
    TradeOffer.load_imported_items(params[:file])
    redirect_to :action => :index, :notice => "CSV imported successfully!"
  end


  permit_params do
    permitted = [:tradeoffer_id, :tradeitem, :startdate, :enddate, :trade_offer_type, :status, :qualif_id, :qualif_desc, :sales_qty, :flex_grp, :flex_desc, :foc_qty, :offer_items, :title]
    permitted
  end

end
