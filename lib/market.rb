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
    
    def self.all
      markets = []
      CSV.readlines("support/markets.csv").each do |line|
        markets << Market.new(line[0].to_i, line[1], line[2], line[3], line[4], line[5], line[6])
      end
      return markets
    end
  end
end
