module Genie::Cli
  # Kills a Genie job by id
  class Kill < Admiral::Command
    include BaseCommand

    define_argument id, required: true

    def run
      handle_client_errors do
        jobs = client.kill(options)

        printer.print(
          jobs,
          flags.columns,
          flags.hide_header
        )
      end
    end

    private def options
      Client::KillOptions.new(id: arguments.id, progress: flags.show_progress)
    end
  end
end
