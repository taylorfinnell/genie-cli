module Genie::Cli
  # Knows how to print a Job or an Array of Jobs in a reasonable output format
  class JobPrinter
    def initialize
      @table = TerminalTable.new
    end

    # Prints jobs
    def print(jobs : Array(Model::Job))
      @table.headings = headers

      jobs.each do |job|
        if job.progress
          @table << [job.id, job.name, job.status, "#{job.progress}%"]
        else
          @table << [job.id, job.name, job.status, "N/A"]
        end
      end

      puts @table.render
    end

    private def headers
      ["id", "name", "status", "progress"]
    end
  end
end
