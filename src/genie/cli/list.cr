module Genie::Cli
  # Lists Genie Jobs
  class List < Admiral::Command
    include BaseCommand

    def run
      handle_client_errors do
        jobs = client.list(list_options)

        printer.print(
          jobs,
          flags.columns,
          flags.hide_header
        )
      end
    end

    private def list_options
      Client::ListOptions.new(progress: flags.show_progress, limit: flags.limit)
    end
  end
end
