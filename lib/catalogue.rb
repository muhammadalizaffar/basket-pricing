class Catalogue
  def initialize(products)
    @products = products.map { |p| [p.code, p] }.to_h
  end

  def find(code)
    @products[code]
  end
end
