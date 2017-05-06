require "logger"

module Genie
  # The Genie `Logger`.
  class Logger
    def initialize(@logger : ::Logger = ::Logger.new(STDOUT))
      @logger.level = log_level
    end

    # Get the `Logger` log level.
    def level
      @logger.level
    end

    # :nodoc:
    private def log_level
      case ENV["LOG_LEVEL"]?.to_s.upcase
      when "DEBUG"
        ::Logger::Severity::DEBUG
      when "INFO"
        ::Logger::Severity::INFO
      when "WARN"
        ::Logger::Severity::WARN
      when "ERROR"
        ::Logger::Severity::ERROR
      when "FATAL"
        ::Logger::Severity::FATAL
      else
        ::Logger::Severity::INFO
      end
    end

    delegate debug, to: @logger
    delegate info, to: @logger
    delegate warn, to: @logger
    delegate error, to: @logger
    delegate fatal, to: @logger
  end
end
