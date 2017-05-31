require "./client/errors"
require "./client/list_options"
require "./client/search_options"
require "./client/kill_options"
require "./client/status_options"
require "./client/open_options"

module Genie
  # A Genie client
  class Client
    def initialize(@config : Config)
      @api = Api.new(@config)
    end

    def open(options : OpenOptions)
      `open #{@config.host}/genie-jobs/#{options.id}/`
    end

    # Search for a Genie job by name.
    def search(options : SearchOptions) : Array(Model::Job)
      resp = get("/jobs", {
        "limit" => options.limit.to_s,
        "name"  => options.name,
      }
      )

      jobs = Array(Model::Job).from_json(resp.body)

      add_progress!(jobs) if options.progress

      jobs
    end

    # List Genie jobs
    def list(options : ListOptions) : Array(Model::Job)
      resp = get("/jobs", {
        "limit" => options.limit.to_s,
      })

      jobs = Array(Model::Job).from_json(resp.body)

      add_progress!(jobs) if options.progress

      jobs
    end

    # Kill a Genie job
    def kill(options : KillOptions) : Array(Model::Job)
      resp = delete("/jobs/#{options.id}")
      job = Model::Job.from_json(resp.body)
      jobs = [job]

      add_progress!(jobs) if options.progress

      jobs
    end

    # Get a Genie job status
    def status(options : StatusOptions) : Array(Model::Job)
      resp = get("/jobs/#{options.id}")
      job = Model::Job.from_json(resp.body)

      jobs = [job]
      add_progress!(jobs) if options.progress
      jobs
    end

    private def get(url, params = {} of String => String)
      handle_api_error { @api.get(url, params) }
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

      uri = URI.parse("#{@config.host}/genie-jobs/#{job.id}/stderr.log")
      stderr = begin
        resp = @api.get(uri)
        resp.body
      rescue ex : Api::NotFoundError
        "0%"
      end

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
