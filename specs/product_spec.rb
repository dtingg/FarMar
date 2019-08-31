require_relative "spec_helper"

describe "Product" do
  describe "initialize" do
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
      proc {
        product = FarMar::Product.new("Not an integer", "Dry Beets", 1)
      }.must_raise ArgumentError
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
        product = FarMar::Product.new(1, "Dry Beets", "Not an integer")
      }.must_raise ArgumentError
    end
    
    it "Requires a positive vendor_id" do
      proc {
        product = FarMar::Product.new(1, "Dry Beets", -11)
      }.must_raise ArgumentError
    end
  end
end
