module Genie::Cli
  # Open a Genie Job
  class Open < Admiral::Command
    include BaseCommand

    define_argument id, required: true

    def run
      client.open(open_options)
    end

    private def open_options
      Client::OpenOptions.new(id: arguments.id)
    end
  end
end
