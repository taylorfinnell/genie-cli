ENV["ENV"] = "test"
ENV["LOG_LEVEL"] = "ERROR"

JOB_FIXTURE = Genie::Model::Job.new(
  id: "123",
  status: "RUNNING",
  started: Time.parse("2017-05-01T19:56:53Z", "%Y-%m-%dT%H:%M:%SZ"),
  finished: Time.parse("2017-05-02T19:56:53Z", "%Y-%m-%dT%H:%M:%SZ"),
  name: "blah",
  output_uri: "uri",
  cluster_id: "cluster-id"
)

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
