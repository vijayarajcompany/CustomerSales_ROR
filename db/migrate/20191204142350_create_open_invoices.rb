class CreateOpenInvoices < ActiveRecord::Migration[5.2]
  def change
    create_table :open_invoices do |t|
      t.string :customercode, null: false
      t.text :open_invoices, array: true, default: []
      t.string :invoice
      t.string :inv_date
      t.string :inv_amount
      t.string :bal_amount

      t.timestamps
    end

    add_index :open_invoices, :customercode
  end
end
