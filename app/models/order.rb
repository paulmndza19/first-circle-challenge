class Order < ApplicationRecord
  validates :customer_name, presence: true
  validates :customer_address, presence: true
  validates :total_price, presence: true, numericality: true
end
