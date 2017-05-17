require "yaml"

module Genie
  # Holds Configuration
  class Config
    DEFAULT_HOST = "localhost"

    YAML.mapping({
      credentials: Credentials?,
      host:        String?,
      printer:     String?,
      columns:     { type: Array(String), default: [] of String }
    })

    # Instantiate a `Config` object from a file.
    def self.from_file(file)
      begin
        from_yaml(File.read(File.expand_path(file)))
      rescue ex : YAML::ParseException
        Genie.logger.warn("WARN: Invalid YAML configuration")
        new
      rescue ex : Errno
        Genie.logger.warn("WARN: YAML configuration missing")
        new
      end
    end

    def initialize(@credentials = nil)
      @host = DEFAULT_HOST
      @columns = [] of String
    end

    # The username used for API auth
    def username
      if credentials.nil?
        nil
      else
        credentials.not_nil!.username
      end
    end

    # The password used for API auth
    def password
      if credentials.nil?
        nil
      else
        credentials.not_nil!.password
      end
    end
  end
end
