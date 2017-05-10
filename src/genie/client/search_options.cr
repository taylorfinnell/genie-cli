module Genie
  class Client
    # Options for searching a jobs
    class SearchOptions
      getter progress
      getter limit
      getter name

      def initialize(@name : String, @progress : Bool, @limit : Int32)
      end
    end
  end
end
