module Genie
  class Client
    # Options for killing a job
    class KillOptions
      getter id

      def initialize(@id : String)
      end
    end
  end
end
