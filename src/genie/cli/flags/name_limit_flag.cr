module Genie::Cli
  module NameLimitFlag
    # Adds a name limit option to any command
    macro included
      define_flag name_limit : Int64?, default: nil, short: n,
          description: "Limit the job name length"
    end
  end
end
