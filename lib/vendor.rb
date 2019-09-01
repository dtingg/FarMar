module FarMar
  class Vendor
    attr_reader :id, :name, :employee_count, :market_id
    def initialize(id, name, employee_count, market_id)
      unless id.instance_of?(Integer) && id > 0
        raise ArgumentError.new("ID must be a postive integer (got #{id}).")
      end
      
      unless employee_count.instance_of?(Integer) && employee_count >= 0
        raise ArgumentError.new("Employee count must be a positive integer.")
      end
      
      unless market_id.instance_of?(Integer) && market_id > 0
        raise ArgumentError.new("Market ID must be a positive integer.")
      end
      
      @id = id
      @name = name
      @employee_count = employee_count
      @market_id = market_id
    end
    
    def products
      Product.find_by_vendor(@id)
    end
    
    def self.all
      vendors = CSV.readlines("support/vendors.csv").map do |line|
        Vendor.new(line[0].to_i, line[1], line[2].to_i, line[3].to_i)
      end
      
      return vendors
    end
    
    def self.find(id)
      all.find do |vendor|
        vendor.id == id
      end
    end
  end
end
