require "http/client"

module Genie
  # Handles the HTTP concerns.
  class Api
    def initialize(@config : Config)
      @headers = HTTP::Headers{"Authorization" => basic_auth}
    end

    # Make a GET request to a path, using the host given by the configuration
    # api uri.
    def get(path : String)
      handle_error do
        _get(full_path(path))
      end
    end

    # Make a GET request using a full URI.
    def get(uri : URI)
      handle_error do
        _get(uri.to_s)
      end
    end

    # Make a DELETE request to a path, using the host given by the configuration
    # api uri.
    def delete(path)
      handle_error do
        _delete(full_path(path))
      end
    end

    # :nodoc:
    private def handle_error
      resp = yield

      if resp.status_code != 200
        raise "Error request failed: #{resp.inspect}"
      else
        resp.body
      end
    end

    # :nodoc:
    private def _get(url)
      HTTP::Client.get(url, headers: @headers)
    end

    # :nodoc:
    private def _delete(url)
      HTTP::Client.delete(url, headers: @headers)
    end

    # :nodoc:
    private def full_path(path)
      "http://#{host}/genie/v2#{path}"
    end

    # :nodoc:
    private def host
      @config.host
    end

    # :nodoc:
    private def basic_auth
      "Basic #{credentials.username}:#{credentials.password}"
    end

    # :nodoc:
    private def credentials
      @config.credentials
    end
  end
end
