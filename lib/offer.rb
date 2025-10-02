class Offer
  def apply(items)
    [items.sum(&:price).to_d, 0.to_d]
  end
end

class RedWidgetOffer < Offer
  def apply(items)
    reds = items.select { |p| p.code == "R01" }
    return [items.sum(&:price).to_d, 0.to_d] if reds.empty?

    full_price = reds.first.price.to_d
    half_price = ((full_price / 2) * 100).floor / 100.0
    half_price = half_price.to_d

    pairs = reds.count / 2
    discounted_reds = pairs * (full_price + half_price)
    remaining_reds  = reds.count.odd? ? full_price : 0.to_d

    red_total = discounted_reds + remaining_reds
    other_total = (items - reds).sum { |p| p.price.to_d }

    subtotal = red_total + other_total
    discount = items.sum { |p| p.price.to_d } - subtotal

    [subtotal, discount]
  end
end
