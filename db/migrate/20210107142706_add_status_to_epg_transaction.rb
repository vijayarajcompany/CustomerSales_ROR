class AddStatusToEpgTransaction < ActiveRecord::Migration[5.2]
  def change
    add_column :epg_transactions, :status, :string
    add_column :epg_transactions, :order_id, :integer
  
  end
end
