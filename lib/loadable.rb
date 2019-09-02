module FarMar
  class Loadable
    attr_reader :id
    
    def initialize(id)
      unless id.instance_of?(Integer) && id > 0
        raise ArgumentError.new("ID must be a positive integer (got #{id}).")
      end
      
      @id = id
    end
    
    def self.from_csv_line(line)
      raise NotImplementedError.new("Implement this in the subclass.")
    end
    
    def self.csv_filename
      raise NotImplementedError.new("Implement this in the subclass.")
    end
    
    def self.all
      CSV.readlines(csv_filename).map do |line|
        from_csv_line(line)
      end
    end
    
    def self.find(id)
      all.find do |entry|
        entry.id == id
      end
    end
  end
end
