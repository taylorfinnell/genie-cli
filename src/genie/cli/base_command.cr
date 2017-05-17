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

    private def print(jobs)
      columns = if flags.columns.any?
                  flags.columns
                else
                  config.columns.not_nil!
                end
      printer.print(jobs, columns, flags.hide_header)
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
      return _printer(config.printer) if config.printer
      _printer(flags.printer)
    end

    # :nodoc:
    private def handle_client_errors
      begin
        yield
      rescue e : Client::Error
        Genie.logger.error(e.message)
      end
    end

    private def _printer(val)
      case val
      when "tabbed"
        TabbedPrinter.new
      else
        TablePrinter.new
      end
    end
  end
end
