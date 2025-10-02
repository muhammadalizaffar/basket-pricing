require "bigdecimal"
require "bigdecimal/util"

require_relative "product"
require_relative "catalogue"
require_relative "delivery_rule"
require_relative "offer"

class Basket
  def initialize(catalogue, delivery_rule, offers = [])
    @catalogue = catalogue
    @delivery_rule = delivery_rule
    @offers = offers
    @items = []
  end

  def add(code)
    product = @catalogue.find(code)
    raise ArgumentError, "Invalid product code: #{code}" unless product
    @items << product
  end

  def total
    subtotal = @items.sum { |i| i.price.to_d }

    @offers.each do |offer|
      new_subtotal, _discount = offer.apply(@items)
      subtotal = new_subtotal.to_d
    end

    delivery_cost = @delivery_rule.cost(subtotal.to_f).to_d

    (subtotal + delivery_cost).round(2, BigDecimal::ROUND_HALF_EVEN).to_f
  end
end
