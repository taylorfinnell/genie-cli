module Genie::Cli
  # Base command, defines help, holds a config and genie client.
  module BaseCommand
    macro included
      include PrinterFlag
      include HeaderFlag
      include ColumnsFlag
      include ConfigFlag
      include ProgressFlag
      include LimitFlag
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
      case flags.printer
      when "tabbed"
        TabbedPrinter.new
      else
        TablePrinter.new
      end
    end

    # :nodoc:
    private def handle_client_errors
      begin
        yield
      rescue e : Client::Error
        Genie.logger.error(e.message)
      end
    end
  end
end
