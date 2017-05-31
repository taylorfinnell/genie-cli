module Genie
  class Client
    # Options for opening a job
    class OpenOptions
      getter id

      def initialize(@id : String)
      end
    end
  end
end
