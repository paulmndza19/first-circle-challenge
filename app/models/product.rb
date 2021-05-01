class Product < ApplicationRecord
  has_many :line_items
  has_one :promotion, class_name: 'ProductsPromotion'

  def has_promotion?
    product_promotion.present?
  end
end
