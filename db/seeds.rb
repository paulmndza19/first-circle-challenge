# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

vga = Product.create(sku: 'vga', name: 'VGA adapter', price: 30.00)
atv = Product.create(sku: 'atv', name: 'Apple TV', price: 109.50)
mbp = Product.create(sku: 'mbp', name: 'MacBook Pro', price: 1399.99)
ipd = Product.create(sku: 'ipd', name: 'Super iPad', price: 549.99)


ProductsPromotion.create(name: 'Buy 2 Get 1', buy: 2, get: 1, product: atv, promotion_rule: 'Promotions::Rules::BuyXGetY')
ProductsPromotion.create(name: 'Bulk Pricing for Super iPad', minimum_bulk_quantity: 5, bulk_price: 499.99, product: ipd, promotion_rule: 'Promotions::Rules::BulkPricing')
ProductsPromotion.create(name: 'MacBook Freebie', freebie_product_id: vga.id, freebie_quantity: 1, product: mbp, promotion_rule: 'Promotions::Rules::Freebies')
