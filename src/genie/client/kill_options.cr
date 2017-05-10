module Genie
  class Client
    # Options for killing a job
    class KillOptions
      getter id
      getter progress

      def initialize(@id : String, @progress : Bool)
      end
    end
  end
end
