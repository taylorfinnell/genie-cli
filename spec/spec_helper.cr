ENV["ENV"] = "test"
ENV["LOG_LEVEL"] = "ERROR"

JOB_JSON = {
  "id" : "123",
  "status" : "RUNNING",
  "started" : "2017-05-01T19:56:53Z",
  "name" : "blah",
  "outputURI" : "uri"
}.to_json

require "spec"
require "secure_random"
require "webmock"
require "../src/genie"
