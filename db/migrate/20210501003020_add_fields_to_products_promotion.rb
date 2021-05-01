class AddFieldsToProductsPromotion < ActiveRecord::Migration[5.1]
  def change
    add_column :products_promotions, :buy, :integer
    add_column :products_promotions, :get, :integer
    add_column :products_promotions, :type, :string
    add_column :products_promotions, :minimum_bulk_quantity, :integer
    add_column :products_promotions, :bulk_price, :decimal, precision: 8, scale: 2
    add_reference :products_promotions, :freebie_product, foreign_key: { to_table: :products }
    add_column :products_promotions, :freebie_quantity, :integer
  end
end
