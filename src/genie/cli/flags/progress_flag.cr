module Genie::Cli
  module ProgressFlag
    # Adds a show_progress option to any command
    macro included
      define_flag show_progress : Bool, default: false, short: p,
          description: "Show the job progress (this is a slow operation)"
    end
  end
end
