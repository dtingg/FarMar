module FarMar
  class Market < Loadable
    attr_reader :name, :address, :city, :county, :state, :zip
    
    def initialize(id, name, address, city, county, state, zip)
      super(id)
      @name = name
      @address = address
      @city = city
      @county = county
      @state = state
      @zip = zip
    end
    
    def vendors
      return Vendor.by_market(id)
    end
    
    def products
      products = []
      
      vendors.each do |vendor|
        vendor.products.each do |product|
          products << product
        end
      end
      return products
    end
    
    def preferred_vendor(date=nil)
      if date
        start_date = Time.parse(date)
        end_date = start_date + (60 * 60 * 24)
        
        preferred_vendor = vendors.max_by do |vendor|
          vendor.sales.sum do |sale|
            sale.purchase_time >= start_date && sale.purchase_time <= end_date ? sale.amount : 0
          end
        end
      else
        preferred_vendor = vendors.max_by do |vendor|
          vendor.sales.sum do |sale|
            sale.amount
          end
        end
      end
      return preferred_vendor
    end
    
    def worst_vendor(date=nil)
      if date
        start_date = Time.parse(date)
        end_date = start_date + (60 * 60 * 24)
        
        preferred_vendor = vendors.min_by do |vendor|
          vendor.sales.sum do |sale|
            sale.purchase_time >= start_date && sale.purchase_time <= end_date ? sale.amount : 0
          end
        end
      else
        preferred_vendor = vendors.min_by do |vendor|
          vendor.sales.sum do |sale|
            sale.amount
          end
        end
      end
      return preferred_vendor
    end
    
    def self.from_csv_line(line)
      self.new(line[0].to_i, line[1], line[2], line[3], line[4], line[5], line[6])
    end
    
    def self.csv_filename
      return "test_data/markets.csv"
    end
    
    def self.search(search_term)
      results = []
      
      all.each do |market|
        if market.name.downcase.include?(search_term.downcase)
          results << market
        end
      end
      
      Vendor.all.each do |vendor|
        if vendor.name.downcase.include?(search_term.downcase)
          results << vendor
        end
      end
      
      return results
    end
  end  
end
