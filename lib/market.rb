require "csv"

module FarMar
  class Market
    attr_reader :id, :name, :address, :city, :county, :state, :zip
    
    def initialize(id, name, address, city, county, state, zip)
      unless id.instance_of?(Integer) && id > 0
        raise ArgumentError.new("ID must be a positive integer (got #{id}).")
      end
      
      @id = id
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
    
    def preferred_vendor
      preferred_vendor = vendors.max_by do |vendor|
        vendor.sales.sum do |sale|
          sale.amount
        end
      end
      return preferred_vendor
    end
    
    def self.all
      markets = CSV.readlines("support/markets.csv").map do |line|
        Market.new(line[0].to_i, line[1], line[2], line[3], line[4], line[5], line[6])
      end
      
      return markets
    end
    
    def self.find(id)
      all.find do |market|
        market.id == id
      end
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
