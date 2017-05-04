module Genie
  # A Genie client
  class Client
    def initialize(@config : Config)
      @api = Api.new(@config)
    end

    # Search for a Genie job by name.
    def search(name : String?, show_progress : Bool, limit : Int32) : Array(Model::Job)
      jobs = Array(Model::Job).from_json(
        @api.get("/jobs?limit=#{limit}&name=#{name}")
      )

      add_progress!(jobs) if show_progress

      jobs
    end

    # List Genie jobs
    def list(show_progress, limit) : Array(Model::Job)
      jobs = Array(Model::Job).from_json(
        @api.get("/jobs?limit=#{limit}")
      )

      add_progress!(jobs) if show_progress
      jobs
    end

    # Kill a Genie job
    def kill(id) : Array(Model::Job)
      job = Model::Job.from_json(
        @api.delete("/jobs/#{id}")
      )

      [job]
    end

    # Get a Genie job status
    def status(id, show_progress) : Array(Model::Job)
      job = Model::Job.from_json(
        @api.get("/jobs/#{id}")
      )

      jobs = [job]
      add_progress!(jobs) if show_progress
      jobs
    end

    # :nodoc:
    private def add_progress!(jobs)
      jobs.each do |job|
        job.progress = fetch_progress(job)
      end
    end

    # dear god...need a better way to parse progress from stderr log
    #
    #
    # :nodoc:
    private def fetch_progress(job)
      regex = /(?<progress>[0-9]+%)+/

      stderr = @api.get(job.stderr_log_uri)

      progress = [] of String

      stderr.each_line do |line|
        mat = line.match(regex)
        if mat != nil
          progress << mat.not_nil!["progress"].gsub("%", "")
        end
      end

      progress = progress.compact.map(&.to_i32)
      if progress.any?
        progress.last
      else
        0.to_i32
      end
    end
  end
end
