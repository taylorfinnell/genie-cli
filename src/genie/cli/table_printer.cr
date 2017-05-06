module Genie::Cli
  # Prints the Jobs in an ASCII table
  class TablePrinter
    include Printer

    def initialize
      @table = TerminalTable.new
    end

    def render(hide_header)
      if hide_header == false
        @table.headings = @rows[0]
      end

      @rows = @rows[1..-1]

      @rows.each do |row|
        @table << row
      end

      puts(@table.render)
    end
  end
end
