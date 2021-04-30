# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Product.create(sku: 'vga', name: 'VGA adapter', price: 30.00)
Product.create(sku: 'atv', name: 'Apple TV', price: 109.50)
Product.create(sku: 'mbp', name: 'MacBook Pro', price: 1399.99)
Product.create(sku: 'ipd', name: 'Super iPad', price: 549.99)
