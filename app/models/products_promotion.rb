class ProductsPromotion < ApplicationRecord
  belongs_to :product
  belongs_to :freebie_product, class_name: 'Product', optional: true

  validates :name, presence: true
end
