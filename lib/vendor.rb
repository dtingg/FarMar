module FarMar
  class Vendor
    attr_reader :id, :name, :employee_count, :market_id
    def initialize(id, name, employee_count, market_id)
      unless id.instance_of?(Integer) && id > 0
        raise ArgumentError.new("ID must be a postive integer (got #{id}).")
      end
      
      unless market_id.instance_of?(Integer) && market_id > 0
        raise ArgumentError.new("Market ID must be a positive integer.")
      end
      
      @id = id
      @name = name
      @employee_count = employee_count
      @market_id = market_id
    end
  end
end
