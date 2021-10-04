class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email, null: false
      t.string :password_digest
      t.references :company
      t.boolean :activated, default: false
      t.string :confirm_token
      t.string :reset_digest
      t.datetime :reset_sent_at
      t.string :ern_number
      t.json :document
      t.integer :status
      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
