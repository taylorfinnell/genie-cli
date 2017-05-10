module Genie::Cli
  module Printer
    @rows = [] of Array(String)

    abstract def render(hide_header = false)

    def print(jobs, columns, hide_header)
      columns = headers if columns.empty?

      if (columns & headers).size == 0
        Genie.logger.error("Invalid attribute list #{columns}")
        return
      end

      @rows << headers

      jobs.each do |job|
        if job.progress
          @rows << [job.id, job.name, job.status, "#{job.progress}%", job.started.to_s]
        else
          @rows << [job.id, job.name, job.status, "N/A", job.started.to_s]
        end
      end

      select_columns(columns)
      render(hide_header)
    end

    private def select_columns(columns)
      @rows = @rows.transpose.select do |(header, x)|
        columns.includes?(header)
      end

      @rows = @rows.transpose
    end

    private def headers
      ["id", "name", "status", "progress", "started"]
    end
  end
end
