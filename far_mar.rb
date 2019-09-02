# gems your project needs
require "csv"
require "time"

# our namespace module
module FarMar; end

# all of our data classes that live in the module
require_relative "lib/loadable"
require_relative "lib/market"
require_relative "lib/product"
require_relative "lib/sale"
require_relative "lib/vendor"
