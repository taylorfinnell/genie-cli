module Genie::Cli
  # Kills a Genie job by id
  class Kill < Admiral::Command
    include BaseCommand

    define_argument id, required: true

    def run
      handle_client_errors do
        print(client.kill(options))
      end
    end

    private def options
      Client::KillOptions.new(id: arguments.id, progress: flags.show_progress)
    end
  end
end
