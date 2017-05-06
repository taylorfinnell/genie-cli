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
        output_uri: {type: String, key: "outputURI"},
        started: Time
      )

      def_equals id, status, name, output_uri, started
    end
  end
end
