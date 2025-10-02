require "rspec"
require_relative "../../lib/product"
require_relative "../../lib/catalogue"
require_relative "../../lib/delivery_rule"
require_relative "../../lib/offer"
require_relative "../../lib/basket"

RSpec.describe Basket do
  let(:products) do
    [
      Product.new("R01", "Red Widget", 32.95),
      Product.new("G01", "Green Widget", 24.95),
      Product.new("B01", "Blue Widget", 7.95)
    ]
  end

  let(:catalogue) { Catalogue.new(products) }
  let(:delivery_rules) do
    DeliveryRule.new([
      { threshold: 50, cost: 4.95 },
      { threshold: 90, cost: 2.95 },
      { threshold: Float::INFINITY, cost: 0.0 }
    ])
  end
  let(:offers) { [RedWidgetOffer.new] }

  it "B01, G01 => 37.85" do
    basket = Basket.new(catalogue, delivery_rules, offers)
    basket.add("B01")
    basket.add("G01")
    expect(basket.total).to eq(37.85)
  end

  it "R01, R01 => 54.37" do
    basket = Basket.new(catalogue, delivery_rules, offers)
    basket.add("R01")
    basket.add("R01")
    expect(basket.total).to eq(54.37)
  end

  it "R01, G01 => 60.85" do
    basket = Basket.new(catalogue, delivery_rules, offers)
    basket.add("R01")
    basket.add("G01")
    expect(basket.total).to eq(60.85)
  end

  it "B01, B01, R01, R01, R01 => 98.27" do
    basket = Basket.new(catalogue, delivery_rules, offers)
    basket.add("B01")
    basket.add("B01")
    basket.add("R01")
    basket.add("R01")
    basket.add("R01")
    expect(basket.total).to eq(98.27)
  end
end
