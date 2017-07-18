ENV["ENV"] = "test"
ENV["LOG_LEVEL"] = "ERROR"

JOB_ATTRS = {
  "id"        => "123",
  "status"    => "RUNNING",
  "started"   => "2017-05-01T19:56:53Z",
  "finished"  => "2017-05-02T19:56:53Z",
  "name"      => "blah",
  "outputURI" => "uri",
}

def self.with_timezone(zone)
  tz = ENV["TZ"]?
  ENV["TZ"] = zone
  ret = yield
  ENV["TZ"] = tz
  ret
end

require "spec"
require "secure_random"
require "webmock"
require "../src/genie"
