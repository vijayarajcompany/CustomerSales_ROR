ActiveAdmin.register Saleorder do
  permit_params do
    permitted = [:customercode, :sales_org, :distr_chain, :division, :deliverydate, :source, :lpo, :createdby, :sender, :products, :itemcode, :quantity, :offer_flag, :promoid, :offerid]
    permitted
  end
end
