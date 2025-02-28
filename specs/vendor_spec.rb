require_relative "spec_helper"

describe "Vendor" do
  describe "#initialize" do
    it "Creates an instance of vendor" do
      vendor = FarMar::Vendor.new(1, "West Seattle Carrots", 10, 5)
      vendor.must_be_kind_of FarMar::Vendor
    end
    
    it "Keeps track of ID" do
      id = 88
      vendor = FarMar::Vendor.new(id, "West Seattle Carrots", 10, 5)
      vendor.must_respond_to :id
      vendor.id.must_equal id
    end
    
    it "Requires an integer ID" do
      proc { FarMar::Vendor.new("not an integer", "test", "test", "test") }.must_raise ArgumentError
    end
    
    it "Requires a positive integer ID" do
      proc { FarMar::Vendor.new(-10, "test", "test", "test") }.must_raise ArgumentError  
    end
    
    it "Keeps track of name" do
      name = "test"
      vendor = FarMar::Vendor.new(1, name, 10, 5)
      vendor.must_respond_to :name
      vendor.name.must_equal name
    end  
    
    it "Keeps track of employee count" do
      employee_count = 10
      vendor = FarMar::Vendor.new(1, "West Seattle Carrots", employee_count, 5)
      vendor.must_respond_to :employee_count
      vendor.employee_count.must_equal employee_count
    end
    
    it "Requires an integer for employee count" do
      proc {FarMar::Vendor.new(1, "West Seattle Carrots", "ten", 5) }.must_raise ArgumentError
    end
    
    it "Requires a positive integer for employee count" do
      proc {FarMar::Vendor.new(1, "West Seattle Carrots", -1, 5) }.must_raise ArgumentError
    end
    
    it "Keeps track of market id" do
      market_id = 5
      vendor = FarMar::Vendor.new(1, "West Seattle Carrots", 10, market_id)
      vendor.must_respond_to :market_id
      vendor.market_id.must_equal market_id
    end
    
    it "Requires an integer market id" do
      proc { FarMar::Vendor.new(1, "West Seattle Carrots", 10, "test") }.must_raise ArgumentError
    end
    
    it "Requires a positive market id" do
      proc { FarMar::Vendor.new(1, "West Seattle Carrots", 10, -5) }.must_raise ArgumentError  
    end
  end
  
  describe "#market" do
    it "Returns the correct market for a vendor" do
      vendor = FarMar::Vendor.find(17)
      
      vendor.market.must_be_kind_of FarMar::Market
      vendor.market.name.must_equal "Quincy Farmers Market"
    end
  end
  
  describe "#products" do
    it "Returns an empty array if no products match" do
      vendor = FarMar::Vendor.new(999999, "test vendor" , 10, 10)
      
      products = vendor.products
      products.must_be_kind_of Array
      products.must_be_empty
    end
    
    it "Returns an array with one Product if one match" do
      vendor_id = 3
      vendor = FarMar::Vendor.new(vendor_id, "test vendor", 10, 10)
      
      products = vendor.products
      products.must_be_kind_of Array
      products.length.must_equal 1
      
      products.each do |product|
        product.must_be_kind_of FarMar::Product
        product.vendor_id.must_equal vendor.id
      end
    end
    
    it "Returns an array with many Products if many match" do
      vendor_id = 4
      vendor = FarMar::Vendor.new(vendor_id, "test vendor", 10, 10)
      
      products = vendor.products
      products.must_be_kind_of Array
      products.length.must_equal 3
      
      products.each do |product|
        product.must_be_kind_of FarMar::Product
        product.vendor_id.must_equal vendor.id
      end
    end
  end
  
  describe "#sales" do
    it "Returns the sales associated with a vendor" do
      vendor = FarMar::Vendor.find(17)
      
      vendor.sales.must_be_kind_of Array
      vendor.sales.length.must_equal 6
      
      vendor.sales.each do |sale|
        sale.must_be_kind_of FarMar::Sale
      end
    end
  end
  
  describe "#revenue" do
    it "Returns the sum of all the vendor's sales in cents" do
      vendor = FarMar::Vendor.find(17)
      
      vendor.revenue.must_be_kind_of Integer
      vendor.revenue.must_equal 24883
    end
  end
  
  describe "self.all" do
    it "Returns an array" do
      vendors = FarMar::Vendor.all
      vendors.must_be_kind_of Array
    end
    
    it "Returns a collection full of Vendors" do
      vendors = FarMar::Vendor.all
      
      vendors.each do |vendor|
        vendor.must_be_kind_of FarMar::Vendor
      end
    end
    
    it "Returns the correct number of Vendors" do
      vendors = FarMar::Vendor.all
      vendors.length.must_equal 268
    end
    
    it "Gets the first Vendor from the file" do
      vendors = FarMar::Vendor.all
      vendors.first.id.must_equal 1
    end
    
    it "Gets the last Vendor from the file" do
      vendors = FarMar::Vendor.all
      vendors.last.id.must_equal 268
    end
  end
  
  describe "self.find" do
    it "Returns nil if the vendor does not exist" do
      vendor = FarMar::Vendor.find(12345)
      vendor.must_be_nil
    end
    
    it "Finds the first vendor" do
      vendor = FarMar::Vendor.find(1)
      vendor.must_be_kind_of FarMar::Vendor
      vendor.id.must_equal 1
    end
    
    it "Finds the last vendor" do 
      vendor = FarMar::Vendor.find(268)
      vendor.must_be_kind_of FarMar::Vendor
      vendor.id.must_equal 268
    end  
  end
  
  describe "self.by_market" do
    it "Returns all vendors who are associated with a market" do
      vendors = FarMar::Vendor.by_market(1)
      
      vendors.length.must_equal 6
      
      vendors.each do |vendor|
        vendor.must_be_kind_of FarMar::Vendor
      end
    end
  end
  
  describe "self.most_revenue" do
    it "Returns the top n vendor instances ranked by total revenue" do
      top_five_vendors = FarMar::Vendor.most_revenue(5)
      
      top_five_vendors.length.must_equal 5
      
      top_five_vendors.each do |vendor|
        vendor.must_be_kind_of FarMar::Vendor
      end
      
      top_five_vendors[0].id.must_equal 5
      top_five_vendors[1].id.must_equal 40
      top_five_vendors[2].id.must_equal 8
      top_five_vendors[3].id.must_equal 44
      top_five_vendors[4].id.must_equal 29
    end
  end
  
  describe "self.most_items" do
    it "Returns the top n vendor instances ranked by total number of items sold" do
      top_five_vendors = FarMar::Vendor.most_items(5)
      
      top_five_vendors.length.must_equal 5
      
      top_five_vendors.each do |vendor|
        vendor.must_be_kind_of FarMar::Vendor
      end
      
      top_five_vendors[0].id.must_equal 40
      top_five_vendors[1].id.must_equal 8
      top_five_vendors[2].id.must_equal 5
      top_five_vendors[3].id.must_equal 10
      top_five_vendors[4].id.must_equal 29  
    end
  end
  
  describe "self.revenue" do
    it "Returns the total revenue for that date across all vendors" do
      daily_revenue = FarMar::Vendor.revenue("November 9, 2013")
      
      daily_revenue.must_equal 174467      
    end
  end
end
