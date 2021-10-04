class AddedAlternativeNumber < ActiveRecord::Migration[5.2]
  def change
    add_column :addresses, :alternative_number, :string
    add_column :addresses, :alternative_number_country_code, :string
    add_column :addresses, :mobile_number_country_code, :string
  end
end
