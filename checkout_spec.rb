require_relative "checkout"

describe Checkout do
  describe "testing without promo" do
    it "with 001 002 003 should return total" do
      co = Checkout.new
      co.scan(001)
      co.scan(002)
      co.scan(003)
      result = co.total
      expect(74.2).to eq(result)
    end
    it "with 001 002 001 should return total" do
      co = Checkout.new
      co.scan(001)
      co.scan(003)
      co.scan(001)
      result = co.total
      expect(38.45).to eq(result)
    end
  end
  describe "testing with promo" do
    promotional_rules = {
      over_60_discount: true,
      same_product_discount: true,
      promo_product: "pants"
    }
    it "with 001 002 003 should return total with discount: 10%" do
      co = Checkout.new(promotional_rules)
      co.scan(001)
      co.scan(002)
      co.scan(003)
      result = co.total
      expect(66.78).to eq(result)
    end
    it "with 001 002 001 should return total with discount: same product" do
      co = Checkout.new(promotional_rules)
      co.scan(001)
      co.scan(003)
      co.scan(001)
      result = co.total
      expect(36.95).to eq(result)
    end
  end
end
