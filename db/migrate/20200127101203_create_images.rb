class CreateImages < ActiveRecord::Migration[5.2]
  def change
    create_table :images do |t|
      t.string :avatar
      t.references :imageable, polymorphic: true
      t.timestamps
      t.timestamps
    end
  end
end
