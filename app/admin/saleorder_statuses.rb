ActiveAdmin.register SaleorderStatus do

  permit_params do
    permitted = [:sale_orderid, :target, :order_status]
    permitted
  end

end
