class ProductsPromotion < ApplicationRecord
  belongs_to :product

  validates :name, presence: true
end
