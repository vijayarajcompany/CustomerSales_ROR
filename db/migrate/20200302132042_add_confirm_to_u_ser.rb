class AddConfirmToUSer < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :confirm, :boolean
  end
end
