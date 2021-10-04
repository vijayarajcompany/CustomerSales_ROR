class CreateOffers < ActiveRecord::Migration[5.2]
  def change
    create_table :offers do |t|
      t.string :name
      t.string :type
      t.integer :rate_type

      t.timestamps
    end
  end
end
