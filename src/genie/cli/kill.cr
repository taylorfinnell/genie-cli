module Genie::Cli
  # Kills a Genie job by id
  class Kill < Admiral::Command
    include BaseCommand
    include ConfigFlag

    define_argument id, required: true

    def run
      job = client.kill(arguments.id)
      printer.print(job)
    end
  end
end
