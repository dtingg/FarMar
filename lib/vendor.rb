module FarMar
  class Vendor < Loadable
    attr_reader :name, :employee_count, :market_id
    def initialize(id, name, employee_count, market_id)
      super(id)
      
      unless employee_count.instance_of?(Integer) && employee_count >= 0
        raise ArgumentError.new("Employee count must be a positive integer.")
      end
      
      unless market_id.instance_of?(Integer) && market_id > 0
        raise ArgumentError.new("Market ID must be a positive integer.")
      end
      
      @name = name
      @employee_count = employee_count
      @market_id = market_id
    end
    
    def market
      return Market.find(market_id)
    end
    
    def products
      return Product.by_vendor(id)
    end
    
    def sales
      return Sale.find_by_vendor(id)
    end
    
    def revenue(date=nil)
      total = sales.sum do |sale|
        sale.amount
      end
      
      return total
    end
    
    def self.from_csv_line(line)
      self.new(line[0].to_i, line[1], line[2].to_i, line[3].to_i)
    end
    
    def self.csv_filename
      return "test_data/vendors.csv"
    end
    
    def self.find(id)
      all.find do |vendor|
        vendor.id == id
      end
    end
    
    def self.by_market(market_id)
      vendors = all.select do |vendor|
        vendor.market_id == market_id
      end
      
      return vendors
    end
    
    def self.most_revenue(number)
      vendors = all.max_by(number) do |vendor|
        vendor.revenue
      end
      return vendors
    end
    
    def self.most_items(number)
      vendors = all.max_by(number) do |vendor|
        vendor.sales.length
      end
      return vendors
    end
    
    def self.revenue(date)
      start_date = Time.parse(date)
      end_date = start_date + (60 * 60 * 24)
      total = 0
      all.each do |vendor|
        vendor.sales.each do |sale|
          if sale.purchase_time >= start_date && sale.purchase_time <= end_date
            total += sale.amount
          end
        end
      end
      return total
    end
  end
end
