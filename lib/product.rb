module FarMar
  class Product < Loadable
    attr_reader :name, :vendor_id
    
    def initialize(id, name, vendor_id)
      super(id)
      
      unless vendor_id.instance_of?(Integer) && vendor_id > 0
        raise ArgumentError.new("Vendor ID must be a positive integer.")
      end
      
      @name = name
      @vendor_id = vendor_id
    end
    
    def vendor
      return Vendor.find(@vendor_id)
    end
    
    def sales
      return Sale.find_by_product(@id)
    end
    
    def number_of_sales
      return sales.length
    end
    
    def self.from_csv_line(line)
      self.new(line[0].to_i, line[1], line[2].to_i)
    end
    
    def self.csv_filename
      return "test_data/products.csv"
    end
    
    def self.by_vendor(vendor_id)
      all.select do |product|
        product.vendor_id == vendor_id
      end
    end
    
    def self.most_revenue(number)
      most_revenue = all.max_by(number) do |product|
        product.sales.sum do |sale|
          sale.amount
        end
      end
      return most_revenue
    end
  end
end
