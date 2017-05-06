module Genie::Cli
  module PrinterFlag
    # Allows different output formatting
    macro included
      define_flag printer : String, default: "table", short: o,
        description: "Output format of CLI"
    end
  end
end
