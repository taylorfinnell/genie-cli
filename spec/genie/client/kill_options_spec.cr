require "../../spec_helper"

module Genie
  describe Client::KillOptions do
    it "has an id and progress" do
      opts = Client::KillOptions.new(id: "id", progress: true)

      opts.id.should eq("id")
      opts.progress.should eq(true)
    end
  end
end
