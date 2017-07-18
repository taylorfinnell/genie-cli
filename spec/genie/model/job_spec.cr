require "../../spec_helper"

module Genie::Model
  describe Job do
    describe "from_json" do
      it "uses local tz" do
        json = JOB_ATTRS.to_json

        job = Job.from_json(json)
        with_timezone("America/New_York") do
          job.started.should eq("2017-05-01 15:56:53")
          job.finished.should eq("2017-05-02 15:56:53")
        end
      end
    end
  end
end
