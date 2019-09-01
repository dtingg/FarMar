require_relative "spec_helper"

describe "Sale" do
  describe "#initialize" do
    
    it "Creates an instance of Sale" do
      sale = FarMar::Sale.new(1, 150, Time.parse("May 5, 2018"), 5, 10)
      sale.must_be_kind_of FarMar::Sale
    end
    
    it "Keeps track of ID" do
      id = 88
      sale =  FarMar::Sale.new(id, 150, Time.parse("May 5, 2018"), 5, 10)
      sale.must_respond_to :id
      sale.id.must_equal id
    end
    
    it "Requires an integer ID" do
      proc { FarMar::Sale.new("one", 150, Time.parse("May 5, 2018"), 5, 10) }.must_raise ArgumentError
    end
    
    it "Requires a positive integer ID" do
      proc { FarMar::Sale.new(-2, 150, Time.parse("May 5, 2018"), 5, 10) }.must_raise ArgumentError  
    end
    
    it "Keeps track of amount" do
      amount = 150
      sale = FarMar::Sale.new(1, amount, Time.parse("May 5, 2018"), 5, 10)
      sale.must_respond_to :amount
      sale.amount.must_equal amount
    end
    
    it "Requires a positive integer for amount" do
      amount = -15
      proc { FarMar::Sale.new(1, amount, Time.parse("May 5, 2018"), 5, 10) }.must_raise ArgumentError      
    end
    
    it "Keeps track of purchase time" do
      time = Time.parse("May 5, 2018")
      sale = FarMar::Sale.new(1, 150, time, 5, 10)
      sale.must_respond_to :purchase_time
      sale.purchase_time.must_equal time
      sale.purchase_time.must_be_kind_of Time
    end
    
    it "Keeps track of vendor id" do
      vendor_id = 5
      sale = FarMar::Sale.new(1, 150, Time.parse("May 5, 2018"), vendor_id, 10)
      sale.must_respond_to :vendor_id
      sale.vendor_id.must_equal vendor_id
    end
    
    it "Requires an integer vendor id" do
      proc { FarMar::Sale.new(1, 150, Time.parse("May 5, 2018"), "test_vendor", 10) }.must_raise ArgumentError
    end
    
    it "Requires a positive integer vendor id" do
      proc { FarMar::Sale.new(1, 150, Time.parse("May 5, 2018"), -3, 10) }.must_raise ArgumentError
    end
    
    it "Keeps track of product id" do
      product_id = 6
      sale = FarMar::Sale.new(1, 150, Time.parse("May 5, 2018"), 5, product_id)
      sale.must_respond_to :product_id
      sale.product_id.must_equal product_id
    end
    
    it "Requires an integer product id" do
      proc { FarMar::Sale.new(1, 150, Time.parse("May 5, 2018"), 5, "one") }.must_raise ArgumentError
    end
    
    it "Requires a positive integer vendor id" do
      proc { FarMar::Sale.new(1, 150, Time.parse("May 5, 2018"), 5, -8) }.must_raise ArgumentError
    end
  end
  
  describe "vendor" do
    it "Finds the Vendor instance that is associated with this sale" do
      sale = FarMar::Sale.new(15,8924,Time.parse("2013-11-10 11:31:16 -0800"),3,4)
      sale.vendor.must_be_kind_of FarMar::Vendor
      sale.vendor.id.must_equal 3
    end
  end
  
  describe "self.all" do
    it "Returns an array" do
      sales = FarMar::Sale.all
      sales.must_be_kind_of Array
    end
    
    it "Returns a collection full of Sales" do
      sales = FarMar::Sale.all
      
      sales.each do |sale|
        sale.must_be_kind_of FarMar::Sale
      end
    end
    
    it "Returns the correct number of Sales" do
      sales = FarMar::Sale.all
      sales.length.must_equal 12798
    end
    
    it "Gets the first Sale from the file" do
      sales = FarMar::Sale.all
      sales.first.id.must_equal 1
    end
    
    it "Gets the last Sale from the file" do
      sales = FarMar::Sale.all
      sales.last.id.must_equal 12001
    end
  end
  
  describe "self.find" do
    it "Returns nil if the sale does not exist" do
      sale = FarMar::Sale.find(9999999)
      sale.must_be_nil
    end
    
    it "Finds the first sale" do
      sale = FarMar::Sale.find(1)
      sale.must_be_kind_of FarMar::Sale
      sale.id.must_equal 1
    end
    
    it "Finds the last sale" do 
      sale = FarMar::Sale.find(12001)
      sale.must_be_kind_of FarMar::Sale
      sale.id.must_equal 12001
    end  
  end
end
