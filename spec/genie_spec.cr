require "./spec_helper"

describe Genie do
  it "has a version" do
    (Genie::VERSION == nil).should be_false
  end
end
