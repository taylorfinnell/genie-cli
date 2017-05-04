module Genie::Cli
  module LimitFlag
    # Adds a limit option to any command
    macro included
      define_flag limit : Int32, default: 10, short: l,
          description: "Limit the number of jobs returned"
    end
  end
end
