module Genie::Cli
  # Lists Genie Jobs
  class List < Admiral::Command
    include BaseCommand

    def run
      handle_client_errors do
        print(client.list(list_options))
      end
    end

    private def list_options
      Client::ListOptions.new(progress: flags.show_progress, limit: flags.limit)
    end
  end
end
