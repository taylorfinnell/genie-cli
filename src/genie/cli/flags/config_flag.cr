module Genie::Cli
  module ConfigFlag
    # Adds a config option to any command
    macro included
      define_flag config : String, default: "~/.genie.yml",
        description: "Specify an alternative .yml configuration file"
    end
  end
end
