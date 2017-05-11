require "yaml"

module Genie
  # Holds Configuration
  class Config
    DEFAULT_HOST = "localhost"

    YAML.mapping({
      credentials: Credentials,
      host:        String,
      printer:     String?,
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

    def initialize(@credentials = Credentials.new)
      @host = DEFAULT_HOST
    end

    # The username used for API auth
    def username
      credentials.username
    end

    # The password used for API auth
    def password
      credentials.password
    end
  end
end
