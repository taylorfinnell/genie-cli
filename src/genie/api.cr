require "uri"
require "http/client"

require "./api/response"
require "./api/errors"

module Genie
  # Handles the HTTP concerns.
  class Api
    def initialize(@config : Config)
      if @config.credentials.nil?
        @headers = HTTP::Headers.new
      else
        @headers = HTTP::Headers{"Authorization" => basic_auth.not_nil!}
      end
    end

    # Make a GET request to a path, using the host given by the configuration
    # api uri.
    def get(path : String, params = {} of String => String)
      handle_error do
        _get(full_path(path), params)
      end
    end

    # Make a GET request using a full URI.
    def get(uri : URI, params = {} of String => String)
      handle_error do
        _get(uri.to_s, params)
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

      if resp.unauthorized?
        raise AuthorizationError.new("Not authorized: '#{resp.inspect}'")
      elsif resp.error?
        if resp.status_code == 404
          raise NotFoundError.new("Request failed, resource not found: #{resp.inspect}")
        else
          raise Error.new("Error request failed: #{resp.inspect}")
        end
      end

      resp
    end

    # :nodoc:
    private def _get(url, params : Hash(String, String))
      _url = url
      if params.any?
        _url = "#{_url}?#{params.map { |k, v| "#{k}=#{URI.escape(v)}" }.join("&")}"
      end

      Response.new(HTTP::Client.get(_url, headers: @headers))
    end

    # :nodoc:
    private def _delete(url)
      Api::Response.new(
        HTTP::Client.delete(url, headers: @headers)
      )
    end

    # :nodoc:
    private def full_path(path)
      "#{host}/genie/v2#{path}"
    end

    # :nodoc:
    private def host
      @config.host
    end

    # :nodoc:
    private def basic_auth
      if credentials.nil?
        nil
      else
        "Basic #{credentials.not_nil!.username}:#{credentials.not_nil!.password}"
      end
    end

    # :nodoc:
    private def credentials
      @config.credentials
    end
  end
end
