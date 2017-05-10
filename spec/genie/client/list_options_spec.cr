require "../../spec_helper"

module Genie
  describe Client::ListOptions do
    it "has an progress and limit" do
      opts = Client::ListOptions.new(progress: true, limit: 69)

      opts.progress.should eq(true)
      opts.limit.should eq(69)
    end
  end
end
