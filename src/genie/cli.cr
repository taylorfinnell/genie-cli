require "./cli/flags"
require "./cli/printer"
require "./cli/tabbed_printer"
require "./cli/table_printer"
require "./cli/base_command"
require "./cli/kill"
require "./cli/list"
require "./cli/search"
require "./cli/status"

module Genie::Cli
  # The base Cli
  class Base < Admiral::Command
    define_help
    define_version Genie::VERSION

    # List Genie jobs.
    register_sub_command ls, Cli::List

    # Kill a Genie job
    register_sub_command kill, Cli::Kill

    # Get Genie Job status.
    register_sub_command status, Cli::Status

    # Search for a Genie job.
    register_sub_command search, Cli::Search

    def run
      puts help
    end
  end
end
