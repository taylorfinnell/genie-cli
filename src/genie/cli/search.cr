module Genie::Cli
  # Search for a Genie job by name
  class Search < Admiral::Command
    include BaseCommand

    define_argument name, required: true

    def run
      handle_client_errors do
        print(client.search(options))
      end
    end

    private def options
      Client::SearchOptions.new(
        name: arguments.name,
        progress: flags.show_progress,
        limit: flags.limit
      )
    end
  end
end
