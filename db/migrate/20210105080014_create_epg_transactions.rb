class CreateEpgTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :epg_transactions do |t|
      t.references :user
      t.jsonb :registration_response
      t.jsonb :payment_response
      t.timestamps
    end
  end
end
