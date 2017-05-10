require "../../spec_helper"

module Genie
  describe Api::Response do
    describe "success?" do
      it "returns true for 200 status" do
        http_resp = HTTP::Client::Response.new(200, "")
        resp = Api::Response.new(http_resp)

        resp.success?.should eq(true)
      end
    end

    describe "unauthorized?" do
      it "returns true for 401 status" do
        http_resp = HTTP::Client::Response.new(401, "")
        resp = Api::Response.new(http_resp)

        resp.unauthorized?.should eq(true)
      end
    end

    describe "body" do
      it "returns the body" do
        http_resp = HTTP::Client::Response.new(200, "body")
        resp = Api::Response.new(http_resp)

        resp.body.should eq("body")
      end
    end

    describe "status_code" do
      it "returns the status_code" do
        http_resp = HTTP::Client::Response.new(200, "body")
        resp = Api::Response.new(http_resp)

        resp.status_code.should eq(200)
      end
    end
  end
end
