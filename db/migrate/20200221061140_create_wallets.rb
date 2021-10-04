class CreateWallets < ActiveRecord::Migration[5.2]
  def change
    create_table :wallets do |t|
      t.float :current_credit_limit
      t.float :outstanding_credit_limit
      t.float :pending_credit_limit
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
