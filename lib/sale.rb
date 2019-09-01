require "csv"

module FarMar
  class Sale
    attr_reader :id, :amount, :purchase_time, :vendor_id, :product_id
    
    def initialize(id, amount, purchase_time, vendor_id, product_id)
      unless id.instance_of?(Integer) && id >= 0
        raise ArgumentError.new("ID must be a positive integer (got #{id}).")
      end
      
      unless amount >= 0
        raise ArgumentError.new("Amount must be a positive number (got #{amount}).")
      end
      
      unless vendor_id.instance_of?(Integer) && vendor_id >= 0
        raise ArgumentError.new("Vendor ID must be a positive integer (got #{vendor_id}).")
      end
      
      unless product_id.instance_of?(Integer) && product_id >= 0
        raise ArgumentError.new("Product ID must be a positive integer (got #{product_id}).")
      end
      
      @id = id
      @amount = amount
      @purchase_time = purchase_time
      @vendor_id = vendor_id
      @product_id = product_id
    end
    
    def self.find_by_vendor(vendor_id)
      all.select do |sale|
        sale.vendor_id == vendor_id
      end
    end
    
    def self.all
      sales = CSV.readlines("support/sales.csv").map do |line|
        Sale.new(line[0].to_i, line[1].to_i, Time.parse(line[2]), line[3].to_i, line[4].to_i)
      end
      return sales
    end
    
    def self.find(id)
      all.find do |sale|
        sale.id == id
      end
    end
  end
end