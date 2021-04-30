class Order < ApplicationRecord
  has_many :line_items
  accepts_nested_attributes_for :line_items, reject_if: :all_blank

  validates :customer_name, presence: true
  validates :customer_address, presence: true
  validates :total_price, presence: true, numericality: true
end
