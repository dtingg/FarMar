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
    
    it "Requires a positive ID" do
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
    
    it "Requires an integer employee count" do
      proc { FarMar::Vendor.new(1, "West Seattle Carrots", "not an integer", 5) }.must_raise ArgumentError
    end
    
    it "Requires a positive employee count" do
      proc { FarMar::Vendor.new(1, "West Seattle Carrots", -1, 5) }.must_raise ArgumentError
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
  
  describe "all" do
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
      vendors.length.must_equal 2690
    end
    
    it "Gets the first Vendor from the file" do
      vendors = FarMar::Vendor.all
      vendors.first.id.must_equal 1
    end
    
    it "Gets the last Vendor from the file" do
      vendors = FarMar::Vendor.all
      vendors.last.id.must_equal 2690
    end
  end
  
  describe "find" do
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
      vendor = FarMar::Vendor.find(2690)
      vendor.must_be_kind_of FarMar::Vendor
      vendor.id.must_equal 2690
    end  
  end
end
