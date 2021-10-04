class AddFieldsToUser < ActiveRecord::Migration[5.2]
  def change
    [:customercode, :route, :address1, :city, :telephone, :paymentterms, :creditlimitdays, :creditlimitamount, :activecustomer, :customergroup, :vat, :excise, :tradeoffer_id, :credit_override, :division].each do |column|
      add_column :users, column, :string
    end
  end
end
