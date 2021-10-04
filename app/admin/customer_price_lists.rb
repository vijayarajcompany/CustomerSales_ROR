ActiveAdmin.register CustomerPriceList do

  permit_params do
    permitted = [:customercode, :itemcode, :startdate, :enddate, :each_sales_price, :carton_sales_price, :delimit]
    permitted
  end

end
