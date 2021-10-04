class CreateCustomerMasters < ActiveRecord::Migration[5.2]
  def change
    create_table :customer_masters do |t|
      t.string :customercode, null: false
      t.string :route
      t.string :customername
      t.string :address1
      t.string :address2
      t.string :address3
      t.string :city
      t.string :telephone
      t.string :paymentterms
      t.string :creditlimitdays
      t.string :creditlimitamount
      t.string :activecustomer
      t.string :customergroup
      t.string :vat
      t.string :excise
      t.string :tradeoffer_id
      t.string :volume_cap
      t.string :outstanding_bill
      t.string :credit_override
      t.string :division
      t.string :credit_limit
      t.string :credit_exposure
      t.string :credit_available

      t.timestamps
    end

    add_index :customer_masters, :customercode, unique: true
  end
end
