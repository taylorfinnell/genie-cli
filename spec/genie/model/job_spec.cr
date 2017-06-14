require "../../spec_helper"

module Genie::Model
  describe Job do
    describe "from_json" do
      it "uses local tz" do
        json = {
          "id" : "123",
          "status" : "RUNNING",
          "started" : "2017-05-01T19:56:53Z",
          "finished" : "2017-05-02T19:56:53Z",
          "name" : "blah",
          "outputURI" : "uri"
        }.to_json

        job = Job.from_json(json)
        with_timezone("America/New_York") do
          job.started.should eq("2017-05-01 15:56:53")
          job.finished.should eq("2017-05-02 15:56:53")
        end
      end
    end
  end
end
