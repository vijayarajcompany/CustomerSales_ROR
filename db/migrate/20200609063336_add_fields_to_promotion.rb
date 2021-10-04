class AddFieldsToPromotion < ActiveRecord::Migration[5.2]

  def change
    add_column :promotions, :customercode, :string
    add_column :promotions, :active_status, :boolean
    add_column :promotions, :sales_item, :string
    add_column :promotions, :sale_qty, :string
    add_column :promotions, :foc_item, :string
    add_column :promotions, :sale_uom, :string
    add_column :promotions, :foc_qty, :string
    add_column :promotions, :start_date, :string
    add_column :promotions, :end_date, :string
    add_column :promotions, :promotion_type, :string
    add_column :promotions, :discount_value, :string
    add_column :promotions, :value1, :string
    add_column :promotions, :value2, :string
    add_column :promotions, :value3, :string
  end
end
