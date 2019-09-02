require_relative "spec_helper"

describe "Market" do
  describe "#initialize" do
    it "Creates an instance of market" do
      market = FarMar::Market.new(1, "People's Co-op Farmers Market", "30th and Burnside", "Portland", "Multnomah", "Oregon", "97202")
      market.must_be_kind_of FarMar::Market
    end
    
    it "Keeps track of ID" do
      id = 88
      market = FarMar::Market.new(
        id, "People's Co-op Farmers Market", 
        "30th and Burnside", "Portland", "Multnomah", "Oregon", "97202"
      )
      market.must_respond_to :id
      market.id.must_equal id
    end
    
    it "Requires an integer ID" do
      proc { FarMar::Market.new("not an integer", "test", "test", "test", "test", "test", "test") }.must_raise ArgumentError
    end
    
    it "Requires a positive ID" do
      proc { FarMar::Market.new(-10, "test", "test", "test", "test", "test", "test") }.must_raise ArgumentError  
    end
    
    it "Keeps track of name" do
      name = "West Seattle Farmers Market"
      market = FarMar::Market.new(1, name, "West Seattle Junction", "Seattle", "King", "Washington", "98136")
      market.must_respond_to :name
      market.name.must_equal name
    end
    
    it "Keeps track of address" do
      address = "test"
      market = FarMar::Market.new(1, "People's Co-op Farmers Market", address, "Portland", "Multnomah", "Oregon", "97202")
      market.must_respond_to :address
      market.address.must_equal address
    end
    
    it "Keeps track of city" do
      city = "test"
      market = FarMar::Market.new(1, "People's Co-op Farmers Market", "30th and Burnside", city, "Multnomah", "Oregon", "97202")
      market.must_respond_to :city
      market.city.must_equal city
    end
    
    it "Keeps track of county" do
      county = "test"
      market = FarMar::Market.new(1, "People's Co-op Farmers Market", "30th and Burnside", "Portland", county, "Oregon", "97202")
      market.must_respond_to :county
      market.county.must_equal county
    end
    
    it "Keeps track of state" do
      state = "test"
      market = FarMar::Market.new(1, "People's Co-op Farmers Market", "30th and Burnside", "Portland", "Multnomah", state, "97202")
      market.must_respond_to :state
      market.state.must_equal state
    end
    
    it "Keeps track of zip" do
      zip = "98136"
      market = FarMar::Market.new(1, "People's Co-op Farmers Market", "30th and Burnside", "Portland", "Multnomah", "Oregon", zip)
      market.must_respond_to :zip
      market.zip.must_equal zip
    end
  end
  
  describe "#vendors" do
    it "Returns all vendors associated with a market" do
      market = FarMar::Market.find(2)
      
      market.vendors.must_be_kind_of Array
      market.vendors.length.must_equal 3
    end
  end
  
  describe "#products" do
    it "Returns a collection of Products that are associated with the market" do
      market = FarMar::Market.find(2)
      
      products = market.products
      products.length.must_equal 9
      
      products.each do |product|
        product.must_be_kind_of FarMar::Product
      end
    end
  end
  
  describe "self.all" do
    it "Returns an array" do
      markets = FarMar::Market.all
      markets.must_be_kind_of Array
    end
    
    it "Returns a collection full of Markets" do
      markets = FarMar::Market.all
      
      markets.each do |market|
        market.must_be_kind_of FarMar::Market
      end
    end
    
    it "Returns the correct number of Markets" do
      markets = FarMar::Market.all
      markets.length.must_equal 500
    end
    
    it "Gets the first Market from the file" do
      markets = FarMar::Market.all
      markets.first.id.must_equal 1
    end
    
    it "Gets the last Market from the file" do
      markets = FarMar::Market.all
      markets.last.id.must_equal 500
    end
  end
  
  describe "self.find" do
    it "Returns nil if the market does not exist" do
      market = FarMar::Market.find(12345)
      market.must_be_nil
    end
    
    it "Finds the first market" do
      market = FarMar::Market.find(1)
      market.must_be_kind_of FarMar::Market
      market.id.must_equal 1
    end
    
    it "Finds the last market" do 
      market = FarMar::Market.find(500)
      market.must_be_kind_of FarMar::Market
      market.id.must_equal 500
    end  
  end
end
