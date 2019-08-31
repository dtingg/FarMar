require_relative "spec_helper"

describe "Market" do
  describe "#initialize" do
    it "Creates an instance of market" do
      market = FarMar::Market.new(1, "People's Co-op Farmers Market", "30th and Burnside", "Portland", "Multnomah", "Oregon", "97202")
      market.must_be_kind_of FarMar::Market
    end
    
    it "Keeps track of ID" do
      id = 88
      market = FarMar::Market.new(id, "People's Co-op Farmers Market", "30th and Burnside", "Portland", "Multnomah", "Oregon", "97202")
      market.must_respond_to :id
      market.id.must_equal id
      
    end
    
    
  end
end
