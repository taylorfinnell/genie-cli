require "../spec_helper"

module Genie::Model
  @@config : Config = Config.new

  @@body : String = [{
    "id" : "123",
    "status" : "RUNNING",
    "started" : "2017-05-01T19:56:53Z",
    "name" : "blah",
    "outputURI" : "uri"
  }].to_json


  describe Client do
    Spec.before_each { WebMock.reset }

    describe "search" do
      it "can search a job" do
        WebMock.stub(:get, "http://localhost/genie/v2/jobs?limit=32&name=blah").
          to_return(body: @@body)

        options = Client::SearchOptions.new("blah")

        client = Client.new(@@config)
        jobs = client.search(options)

        jobs.should eq(Array(Model::Job).from_json(@@body))
      end
    end

    it "sends proper options to api" do
      WebMock.stub(:get, "http://localhost/genie/v2/jobs?limit=2&name=blah").
        to_return(body: @@body)

      options = Client::SearchOptions.new("blah", limit: 2)

      client = Client.new(@@config)
      jobs = client.search(options)

      jobs.should eq(Array(Model::Job).from_json(@@body))
    end

    it "can parse job logs to get job progress" do
      WebMock.stub(:get, "http://localhost/genie-jobs/123/stderr.log").
        to_return(body: "line\nblah\n1%\nblah\n100%")

      WebMock.stub(:get, "http://localhost/genie/v2/jobs?limit=32&name=blah").
        to_return(body: @@body)

      options = Client::SearchOptions.new("blah", progress: true)

      client = Client.new(@@config)
      jobs = client.search(options)

      jobs.size.should eq(1)
      jobs.first.progress.should eq(100)
    end
  end
end
