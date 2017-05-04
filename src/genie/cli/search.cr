module Genie::Cli
  # Search for a Genie job by name
  class Search < Admiral::Command
    include BaseCommand

    include ConfigFlag
    include ProgressFlag
    include LimitFlag

    define_argument name, required: true

    def run
      jobs = client.search(
        arguments.name,
        flags.show_progress || false,
        flags.limit
      )

      puts printer.print(jobs)
    end
  end
end
