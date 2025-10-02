class DeliveryRule
  def initialize(rules)
    @rules = rules
  end

  def cost(subtotal)
    @rules.each do |rule|
      return rule[:cost] if subtotal < rule[:threshold]
    end
  end
end
