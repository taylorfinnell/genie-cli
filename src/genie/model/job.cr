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
        started: Time,
        finished: Time,
        cluster_id: {type: String, key: "executionClusterId"}
      )

      def initialize(@id : String, @status : String, @name : String, @output_uri : String, @started : Time, @finished : Time, @cluster_id : String)
      end

      def started
        @started.to_local.to_s("%Y-%m-%d %H:%M:%S")
      end

      def finished
        if @status == "RUNNING"
          "N/A"
        else
          @finished.to_local.to_s("%Y-%m-%d %H:%M:%S")
        end
      end

      def_equals id, status, name, output_uri, started
    end
  end
end
