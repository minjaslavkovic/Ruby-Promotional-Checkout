require 'checkout'
require 'product'

describe 'CheckoutTest' do
  let(:checkout) do
    products = [
      Product.new(1, 'Lavander heart', {
                    1 => 9.25,
                    2 => 8.50
                  }),
      Product.new(2, 'Personalised cufflinks', { 1 => 45.00 }),
      Product.new(3, 'Kids T-Shirt', { 1 => 19.95 })
    ]
    promotional_rules = {
      60 => 10
    }
    Checkout.new(products, promotional_rules)
  end

  it 'no discounts applied' do
    checkout.scan(1)
    checkout.scan(3)
    expect(checkout.total).to be_within(0.01).of(29.2)
  end

  it 'total price discount applied' do
    checkout.scan(1)
    checkout.scan(2)
    checkout.scan(3)
    expect(checkout.total).to be_within(0.01).of(66.78)
  end

  it 'per-item discount applied' do
    checkout.scan(1)
    checkout.scan(3)
    checkout.scan(1)
    expect(checkout.total).to be_within(0.01).of(36.95)
  end

  it 'both discounts applied' do
    checkout.scan(1)
    checkout.scan(2)
    checkout.scan(1)
    checkout.scan(3)
    expect(checkout.total).to be_within(0.01).of(73.76)
  end
end
