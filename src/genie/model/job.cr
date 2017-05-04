require "json"

module Genie
  module Model
    # Represents a Genie job.
    class Job
      @progress : Int32?
      property progress = nil

      JSON.mapping(
        id: String,
        status: String,
        name: String,
        output_uri: {type: String, key: "outputURI"}
      )

      # A valid URI for the Genie job.
      def stderr_log_uri
        URI.parse(output_uri + "/stderr.log")
      end
    end
  end
end
