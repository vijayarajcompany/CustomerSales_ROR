class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.references :addressable, polymorphic: true
      t.string :title
      t.text :address
      t.float :latitude
      t.float :longitude
      t.timestamps
    end
  end
end
