class LineItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :price, presence: true, numericality: true
  validates :total, presence: true, numericality: true
  validates :quantity, presence: true, numericality: true
end
