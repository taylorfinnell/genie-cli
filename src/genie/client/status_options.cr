module Genie
  class Client
    # Options for getting job status
    class StatusOptions
      getter id
      getter progress

      def initialize(@id : String, @progress : Bool)
      end
    end
  end
end
