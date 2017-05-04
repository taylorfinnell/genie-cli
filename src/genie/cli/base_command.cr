module Genie::Cli
  # Base command, defines help, holds a config and genie client.
  module BaseCommand
    macro included
      define_help
    end

    # :nodoc:
    private def config
      Config.from_file(flags.config)
    end

    # :nodoc:
    private def client
      Client.new(config)
    end

    # :nodoc:
    private def printer
      JobPrinter.new
    end
  end
end
