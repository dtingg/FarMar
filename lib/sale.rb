module FarMar
  class Sale < Loadable
    attr_reader :amount, :purchase_time, :vendor_id, :product_id
    
    def initialize(id, amount, purchase_time, vendor_id, product_id)
      super(id)
      
      unless amount >= 0
        raise ArgumentError.new("Amount must be a positive number (got #{amount}).")
      end
      
      unless vendor_id.instance_of?(Integer) && vendor_id >= 0
        raise ArgumentError.new("Vendor ID must be a positive integer (got #{vendor_id}).")
      end
      
      unless product_id.instance_of?(Integer) && product_id >= 0
        raise ArgumentError.new("Product ID must be a positive integer (got #{product_id}).")
      end
      
      @amount = amount
      @purchase_time = purchase_time
      @vendor_id = vendor_id
      @product_id = product_id
    end
    
    def vendor
      return Vendor.find(vendor_id)
    end
    
    def product
      return Product.find(product_id)
    end
    
    def self.from_csv_line(line)
      self.new(line[0].to_i, line[1].to_i, Time.parse(line[2]), line[3].to_i, line[4].to_i)
    end
    
    def self.csv_filename
      return "test_data/sales.csv"
    end
    
    def self.find_by_vendor(vendor_id)
      all.select do |sale|
        sale.vendor_id == vendor_id
      end
    end
    
    def self.find_by_product(product_id)
      all.select do |sale|
        sale.product_id == product_id
      end
    end
    
    def self.between(beginning_time, end_time)
      sales = all.select do |sale|
        sale.purchase_time >= beginning_time && sale.purchase_time <= end_time
      end
      return sales
    end
  end
end
