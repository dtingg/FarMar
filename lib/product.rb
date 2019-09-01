module FarMar
  class Product
    attr_reader :id, :name, :vendor_id
    
    def initialize(id, name, vendor_id)
      unless id.instance_of?(Integer) && id > 0
        raise ArgumentError.new("ID must be a positive integer (got #{id}).")
      end
      
      unless vendor_id.instance_of?(Integer) && vendor_id > 0
        raise ArgumentError.new("Vendor ID must be a positive integer.")
      end
      
      @id = id
      @name = name
      @vendor_id = vendor_id
    end
    
    def vendor
      return Vendor.find(@vendor_id)
    end
    
    def self.all
      products = CSV.readlines("support/products.csv").map do |line|
        Product.new(line[0].to_i, line[1], line[2].to_i)
      end
      
      return products
    end
    
    def self.find(id)
      all.find do |product|
        product.id == id
      end
    end
    
    def self.find_by_vendor(vendor_id)
      all.select do |product|
        product.vendor_id == vendor_id
      end
    end
  end
end
