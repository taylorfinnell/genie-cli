require "../spec_helper"

module Genie
  describe Logger do
    it "can debug" do
      logger = Logger.new
      logger.responds_to?(:debug).should eq true
    end

    it "can info" do
      logger = Logger.new
      logger.responds_to?(:info).should eq true
    end

    it "can warn" do
      logger = Logger.new
      logger.responds_to?(:warn).should eq true
    end
  end
end
