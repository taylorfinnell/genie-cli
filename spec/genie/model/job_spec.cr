require "../../spec_helper"

module Genie::Model
  describe Job do
    describe "finished" do
      it "shows as N/A if job is still running" do
        job = JOB_FIXTURE
        job.status = "RUNNING"

        job.finished.should eq("N/A")
      end
    end

    describe "from_json" do
      it "uses local tz" do
        job = JOB_FIXTURE
        job.status = "FINISHED"

        with_timezone("America/New_York") do
          job.started.should eq("2017-05-01 15:56:53")
          job.finished.should eq("2017-05-02 15:56:53")
        end
      end
    end
  end
end
