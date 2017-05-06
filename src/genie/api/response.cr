module Genie
  class Api
    # Represents a response from the Api.
    class Response
      def initialize(@response : HTTP::Client::Response)
      end

      # Returns `true` if the response is a success, `false` otherwise.
      def success?
        (200..299).includes?(@response.status_code)
      end

      # Returns `true` if the response is unauthorized, `false` otherwise.
      def unauthorized?
        @response.status_code == 401
      end

      # Returns `true` if the response failed, `false` otherwise.
      def error?
        !success?
      end

      # Returns response body
      def body
        @response.body
      end

      # Returns the response HTTP status code
      def status_code
        @response.status_code
      end
    end
  end
end
