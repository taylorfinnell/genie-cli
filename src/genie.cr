require "admiral"
require "terminal_table"

require "./genie/*"

module Genie
  @@logger : Logger = Logger.new

  def self.logger
    @@logger
  end

  Cli::Base.run unless ENV["ENV"]? == "test"
end
