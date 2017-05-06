module Genie::Cli
  module ColumnsFlag
    # Allows showing of only certain columns in the output
    macro included
      define_flag columns : Array(String), default: [] of String, short: c,
        description: "Show only certain columns"
    end
  end
end
