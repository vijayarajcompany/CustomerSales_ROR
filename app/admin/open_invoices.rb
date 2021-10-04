ActiveAdmin.register OpenInvoice do

  permit_params do
    permitted = [:customercode, :open_invoices, :invoice, :inv_date, :inv_amount, :bal_amount]
    permitted
  end

end
