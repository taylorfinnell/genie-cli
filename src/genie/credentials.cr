require "yaml"

module Genie
  # Holds a username and password required for the Api basic authentication.
  class Credentials
    DEFAULT_USERNAME = "admin"
    DEFAULT_PASSWORD = "admin"

    YAML.mapping({
      username: String,
      password: String,
    })

    def initialize(@username = DEFAULT_USERNAME, @password = DEFAULT_PASSWORD)
    end
  end
end
