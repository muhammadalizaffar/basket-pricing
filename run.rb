require_relative "lib/product"
require_relative "lib/catalogue"
require_relative "lib/delivery_rule"
require_relative "lib/offer"
require_relative "lib/basket"

products = [
  Product.new("R01", "Red Widget", 32.95),
  Product.new("G01", "Green Widget", 24.95),
  Product.new("B01", "Blue Widget", 7.95)
]

catalogue = Catalogue.new(products)
delivery_rules = DeliveryRule.new([
  { threshold: 50, cost: 4.95 },
  { threshold: 90, cost: 2.95 },
  { threshold: Float::INFINITY, cost: 0.0 }
])
offers = [RedWidgetOffer.new]

basket = Basket.new(catalogue, delivery_rules, offers)
basket.add("B01")
basket.add("G01")
puts basket.total
