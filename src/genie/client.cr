require "./client/errors"
require "./client/list_options"
require "./client/search_options"
require "./client/kill_options"
require "./client/status_options"

module Genie
  # A Genie client
  class Client
    def initialize(@config : Config)
      @api = Api.new(@config)
    end

    # Search for a Genie job by name.
    def search(options : SearchOptions) : Array(Model::Job)
      json = get("/jobs?limit=#{options.limit}&name=#{options.name}")
      jobs = Array(Model::Job).from_json(json)

      add_progress!(jobs) if options.progress

      jobs
    end

    # List Genie jobs
    def list(options : ListOptions) : Array(Model::Job)
      json = get("/jobs?limit=#{options.limit}")
      jobs = Array(Model::Job).from_json(json)

      add_progress!(jobs) if options.progress

      jobs
    end

    # Kill a Genie job
    def kill(options : KillOptions) : Array(Model::Job)
      json = delete("/jobs/#{options.id}")
      job = Model::Job.from_json(json)

      [job]
    end

    # Get a Genie job status
    def status(options : StatusOptions) : Array(Model::Job)
      json = get("/jobs/#{options.id}")
      job = Model::Job.from_json(json)

      jobs = [job]
      add_progress!(jobs) if options.progress
      jobs
    end

    private def get(url)
      handle_api_error { @api.get(url) }
    end

    private def delete(url)
      handle_api_error { @api.delete(url) }
    end

    private def handle_api_error
      begin
        yield
      rescue e : Api::Error
        raise Error.new(e.message)
      end
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

      uri = URI.parse("http://#{@config.host}/genie-jobs/#{job.id}/stderr.log")
      stderr = @api.get(uri)

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
