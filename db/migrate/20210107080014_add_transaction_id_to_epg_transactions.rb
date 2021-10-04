class AddTransactionIdToEpgTransactions < ActiveRecord::Migration[5.2]
  def change
    add_column :epg_transactions, :transaction_id, :string
    add_column :epg_transactions, :customer_name, :string
  end
end
