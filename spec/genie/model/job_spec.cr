require "../../spec_helper"

module Genie::Model
  describe Job do
    describe "from_json" do
      Spec.before_each do
        @@OLD_TZ = ENV["TZ"]?
        # ENV["TZ"] = "Eastern Time (US & Canada)"
      end

      Spec.after_each do
        if @@OLD_TZ != nil
          ENV["TZ"] = @@OLD_TZ
        else
          ENV["TZ"] = ""
        end
      end

      it "uses local tz" do
        json = {
          "id" : "123",
          "status" : "RUNNING",
          "started" : "2017-05-01T19:56:53Z",
          "name" : "blah",
          "outputURI" : "uri"
        }.to_json

        job = Job.from_json(json)
        job.started.should eq("2017-05-01 15:56:53")
      end
    end
  end
end
