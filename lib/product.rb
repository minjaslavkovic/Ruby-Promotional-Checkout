class Product
  attr_reader :code, :name

  def initialize(code, name, prices)
    @code = code
    @name = name
    @prices = prices
  end

  def price_for_count(count)
    valid_promos = @prices.keys.select { |q| q <= count }
    price = @prices[valid_promos.max]
    count * price
  end
end
