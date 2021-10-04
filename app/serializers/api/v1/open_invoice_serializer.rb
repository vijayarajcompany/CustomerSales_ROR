class Api::V1::OpenInvoiceSerializer < ActiveModel::Serializer
  attributes :customercode, :open_invoices, :invoice, :inv_date, :inv_amount, :bal_amount
end