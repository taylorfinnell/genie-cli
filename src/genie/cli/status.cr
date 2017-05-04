module Genie::Cli
  # Gets the status of a Genie job
  class Status < Admiral::Command
    include BaseCommand
    include ConfigFlag
    include ProgressFlag

    define_argument id, required: true

    def run
      job = client.status(arguments.id, flags.show_progress)
      printer.print(job)
    end
  end
end
