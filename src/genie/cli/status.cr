module Genie::Cli
  # Gets the status of a Genie job
  class Status < Admiral::Command
    include BaseCommand

    define_argument id, required: true

    def run
      handle_client_errors do
        print(client.status(options))
      end
    end

    private def options
      Client::StatusOptions.new(id: arguments.id, progress: flags.show_progress)
    end
  end
end
