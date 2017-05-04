module Genie::Cli
  # Lists Genie Jobs
  class List < Admiral::Command
    include BaseCommand

    include ConfigFlag
    include ProgressFlag
    include LimitFlag

    def run
      jobs = client.list(
        flags.show_progress || false,
        flags.limit
      )

      printer.print(jobs)
    end
  end
end
