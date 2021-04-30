class Order < ApplicationRecord
  has_many :line_items

  validates :customer_name, presence: true
  validates :customer_address, presence: true
  validates :total_price, presence: true, numericality: true
end
