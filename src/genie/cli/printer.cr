module Genie::Cli
  module Printer
    @rows = [] of Array(String)
    @io : IO = STDOUT

    property io

    abstract def render(hide_header = false)

    def print(jobs, columns, hide_header, name_length = -1)
      columns = headers if columns.empty?

      if (columns & headers).size == 0
        Genie.logger.error("Invalid attribute list #{columns}")
        return
      end

      @rows << headers

      jobs.each do |job|
        if job.progress
          @rows << [job.id, job.name[0..name_length], job.status, "#{job.progress}%", job.started.to_s, job.finished.to_s]
        else
          @rows << [job.id, job.name[0..name_length], job.status, "N/A", job.started.to_s, job.finished.to_s]
        end
      end

      if jobs.any?
        select_columns(columns)
      else
        hide_header = false
      end

      render(hide_header)
    end

    def string
      @io.rewind
      @io.gets_to_end
    end

    private def write(data)
      @io.puts(data)
    end

    private def select_columns(columns)
      @rows = @rows.transpose.select do |(header, x)|
        columns.includes?(header)
      end

      @rows = @rows.transpose
    end

    private def headers
      ["id", "name", "status", "progress", "started", "finished"]
    end
  end
end
