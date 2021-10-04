ActiveAdmin.register CustomerMaster do

  permit_params do
    permitted = [:customercode, :route, :customername, :address1, :address2, :address3, :city, :telephone, :paymentterms, :creditlimitdays, :creditlimitamount, :activecustomer, :customergroup, :vat, :excise, :tradeoffer_id, :volume_cap, :outstanding_bill, :credit_override, :division, :credit_limit, :credit_exposure, :credit_available]
  end

end
