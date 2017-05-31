module Genie::Cli
  module EnvFlag
    # Adds a limit option to any command
    macro included
      define_flag env : String?, default: nil, short: e,
          description: "The env to use"
    end
  end
end
