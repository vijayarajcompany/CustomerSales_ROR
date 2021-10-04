class CreateAboutPages < ActiveRecord::Migration[5.2]
  def change
    create_table :about_pages do |t|
      t.text :content
      t.timestamps
    end
  end
end
