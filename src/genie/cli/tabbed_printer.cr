module Genie::Cli
  # Prints the Jobs tabbed delimited
  class TabbedPrinter
    include Printer

    def render(hide_header)
      @rows = @rows[1..-1] if hide_header

      @rows.each do |row|
        write(row.join("\t"))
      end
    end
  end
end
