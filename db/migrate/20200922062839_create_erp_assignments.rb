class CreateErpAssignments < ActiveRecord::Migration[5.2]
  def change
    create_table :erp_assignments do |t|
      t.string :erp_number
      t.timestamps
    end
  end
end
