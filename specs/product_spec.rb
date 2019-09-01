require_relative "spec_helper"

describe "Product" do
  describe "#initialize" do
    it "Creates an instance of product" do
      product = FarMar::Product.new(1, "Dry Beets", 1)
      product.must_be_kind_of FarMar::Product
    end
    
    it "Keeps track of ID" do
      id = 1337
      product = FarMar::Product.new(id, "Dry Beets", 1)
      product.must_respond_to :id
      product.id.must_equal id
    end
    
    it "Requires an integer ID" do
      proc { FarMar::Product.new("Not an integer", "Dry Beets", 1) }.must_raise ArgumentError
    end
    
    it "Requires a positive integer ID" do
      proc { FarMar::Product.new(-1, "Dry Beets", 1) }.must_raise ArgumentError
    end
    
    it "Keeps track of name" do
      name = "test"
      product = FarMar::Product.new(1, name, 1)
      product.must_respond_to :name
      product.name.must_equal name
    end
    
    it "Keeps track of vendor_id" do
      vendor_id = 10
      product = FarMar::Product.new(1, "Dry Beets", vendor_id)
      product.must_respond_to :vendor_id
      product.vendor_id.must_equal vendor_id
    end
    
    it "Requires an integer vendor_id" do
      proc {
        FarMar::Product.new(1, "Dry Beets", "Not an integer")
      }.must_raise ArgumentError
    end
    
    it "Requires a positive integer vendor_id" do
      proc {
        FarMar::Product.new(1, "Dry Beets", -11)
      }.must_raise ArgumentError
    end
    
  end
  
  describe "#vendor" do
    it "Returns an instance of Vendor with the correct ID" do
      product = FarMar::Product.new(1337, "test product", 10)
      vendor = product.vendor
      vendor.must_be_kind_of FarMar::Vendor
      vendor.id.must_equal product.vendor_id
    end
    
    it "Returns nil when the vendor_id doesn't correspond to a real vendor" do
      vendor_id = 999999
      FarMar::Vendor.find(vendor_id).must_be_nil "Oops! Didn't expect vendor #{vendor_id} to exist. "
      product = FarMar::Product.new(1337, "test product", vendor_id)
      vendor = product.vendor
      vendor.must_be_nil
    end
  end
  
  describe "all" do
    it "Returns an array" do
      products = FarMar::Product.all
      products.must_be_kind_of Array
    end
    
    it "Returns a collection full of Products" do
      products = FarMar::Product.all
      
      products.each do |product|
        product.must_be_kind_of FarMar::Product
      end
    end
    
    it "Returns the correct number of Products" do
      products = FarMar::Product.all
      products.length.must_equal 8193
    end
    
    it "Gets the first Product from the file" do
      products = FarMar::Product.all
      products.first.id.must_equal 1
    end
    
    it "Gets the last Product from the file" do
      products = FarMar::Product.all
      products.last.id.must_equal 8193
    end
  end
  
  describe "find" do
    it "Returns nil if the product does not exist" do
      product = FarMar::Product.find(12345)
      product.must_be_nil
    end
    
    it "Finds the first product" do
      product = FarMar::Product.find(1)
      product.must_be_kind_of FarMar::Product
      product.id.must_equal 1
    end
    
    it "Finds the last product" do 
      product = FarMar::Product.find(8193)
      product.must_be_kind_of FarMar::Product
      product.id.must_equal 8193
    end  
  end
end
