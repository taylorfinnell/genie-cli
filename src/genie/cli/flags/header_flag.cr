module Genie::Cli
  module HeaderFlag
    macro included
      define_flag hide_header : Bool, default: false, short: h,
          description: "Show column headers in output"
    end
  end
end
