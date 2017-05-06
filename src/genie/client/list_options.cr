module Genie
  class Client
    # Options for listing a job
    class ListOptions
      getter progress
      getter limit

      def initialize(@progress = false, @limit = 32)
      end
    end
  end
end
