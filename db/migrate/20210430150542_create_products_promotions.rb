class CreateProductsPromotions < ActiveRecord::Migration[5.1]
  def change
    create_table :products_promotions do |t|
      t.string :name
      t.text :description
      t.belongs_to :product, foreign_key: true

      t.timestamps
    end
  end
end
