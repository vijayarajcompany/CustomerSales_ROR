class CreatePacks < ActiveRecord::Migration[5.2]
  def change
    create_table :packs do |t|
      t.string :name
      t.integer :count
      t.references :packable, polymorphic: true
      t.timestamps
    end
  end
end
