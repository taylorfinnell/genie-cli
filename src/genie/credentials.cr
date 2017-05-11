require "yaml"

module Genie
  # Holds a username and password required for the Api basic authentication.
  class Credentials
    YAML.mapping({
      username: String?,
      password: String?,
    })

    def initialize(@username = nil, @password = nil)
    end
  end
end
