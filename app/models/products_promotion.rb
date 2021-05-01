class ProductsPromotion < ApplicationRecord
  belongs_to :product
  belongs_to :freebie_product, class_name: 'Product'

  validates :name, presence: true
end
