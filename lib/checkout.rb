require_relative 'product'

class Checkout
  def initialize(products, promotional_rules)
    @products = products # array of Product
    @promotional_rules = promotional_rules
    @basket = {}
  end

  def scan(product_code)
    @basket[product_code] = 0 unless @basket.key?(product_code)
    @basket[product_code] += 1
  end

  def total
    product_by_id = {}
    @products.each { |p| product_by_id[p.code] = p }
    sum = 0
    @basket.each { |id, count| sum += product_by_id[id].price_for_count(count) }
    promo_percent = 0
    valid_promos = @promotional_rules.keys.select { |price| price <= sum }
    promo_percent = @promotional_rules[valid_promos.max] unless valid_promos.empty?
    sum *= (100.0 - promo_percent) / 100.0
    sum
  end
end
