require "../spec_helper"

module Genie::Model
  @@config : Config = Config.new

  @@job :  String = {
    "id" : "123",
    "status" : "RUNNING",
    "started" : "2017-05-01T19:56:53Z",
    "finished" : "2017-05-02T19:56:53Z",
    "name" : "blah",
    "outputURI" : "uri"
  }.to_json

  @@jobs : String = [{
    "id" : "123",
    "status" : "RUNNING",
    "started" : "2017-05-01T19:56:53Z",
    "finished" : "2017-05-02T19:56:53Z",
    "name" : "blah",
    "outputURI" : "uri"
  }].to_json


  describe Client do
    Spec.before_each { WebMock.reset }

    describe "list" do
      it "can list a job" do
        WebMock.stub(:get, "http://localhost/genie/v2/jobs?limit=32").
          to_return(body: @@jobs)

        options = Client::ListOptions.new(limit: 32, progress: false)

        client = Client.new(@@config)
        jobs = client.list(options)

        jobs.should eq(Array(Model::Job).from_json(@@jobs))
      end

      it "can parse job logs to get job progress" do
        WebMock.stub(:get, "http://localhost/genie-jobs/123/stderr.log").
          to_return(body: "line\nblah\n1%\nblah\n100%")

        WebMock.stub(:get, "http://localhost/genie/v2/jobs?limit=32").
          to_return(body: @@jobs)

        options = Client::ListOptions.new(progress: true, limit: 32)

        client = Client.new(@@config)
        jobs = client.list(options)

        jobs.size.should eq(1)
        jobs.first.progress.should eq(100)
      end

      it "is ok if the stderr is not written yet" do
        WebMock.stub(:get, "http://localhost/genie-jobs/123/stderr.log").
          to_return(status: 404)

        WebMock.stub(:get, "http://localhost/genie/v2/jobs?limit=32").
          to_return(body: @@jobs)

        options = Client::ListOptions.new(progress: true, limit: 32)

        client = Client.new(@@config)
        jobs = client.list(options)

        jobs.size.should eq(1)
        jobs.first.progress.should eq(0)
      end
    end

    describe "status" do
      it "can get job status" do
        WebMock.stub(:get, "http://localhost/genie/v2/jobs/123").
          to_return(body: @@job)

        options = Client::StatusOptions.new(id: "123", progress: false)

        client = Client.new(@@config)
        jobs = client.status(options)

        jobs.should eq(Array(Model::Job).from_json(@@jobs))
      end

      it "can parse job logs to get job progress" do
        WebMock.stub(:get, "http://localhost/genie-jobs/123/stderr.log").
          to_return(body: "line\nblah\n1%\nblah\n100%")

        WebMock.stub(:get, "http://localhost/genie/v2/jobs/123").
          to_return(body: @@job)

        options = Client::StatusOptions.new(id: "123", progress: true)

        client = Client.new(@@config)
        jobs = client.status(options)

        jobs.size.should eq(1)
        jobs.first.progress.should eq(100)
      end

      it "be ok if stderr is not avaiable" do
        WebMock.stub(:get, "http://localhost/genie-jobs/123/stderr.log").
          to_return(status: 404)

        WebMock.stub(:get, "http://localhost/genie/v2/jobs/123").
          to_return(body: @@job)

        options = Client::StatusOptions.new(id: "123", progress: true)

        client = Client.new(@@config)
        jobs = client.status(options)

        jobs.size.should eq(1)
        jobs.first.progress.should eq(0)
      end
    end

    describe "kill" do
      it "can kill a job" do
        WebMock.stub(:delete, "http://localhost/genie/v2/jobs/123").
          to_return(body: @@job)

        options = Client::KillOptions.new(id: "123", progress: false)

        client = Client.new(@@config)
        jobs = client.kill(options)

        jobs.should eq(Array(Model::Job).from_json(@@jobs))
      end

      it "can parse job logs to get job progress" do
        WebMock.stub(:get, "http://localhost/genie-jobs/123/stderr.log").
          to_return(body: "line\nblah\n1%\nblah\n100%")

        WebMock.stub(:delete, "http://localhost/genie/v2/jobs/123").
          to_return(body: @@job)

        options = Client::KillOptions.new(id: "123", progress: true)

        client = Client.new(@@config)
        jobs = client.kill(options)

        jobs.size.should eq(1)
        jobs.first.progress.should eq(100)
      end

      it "be ok if stderr is not written" do
        WebMock.stub(:get, "http://localhost/genie-jobs/123/stderr.log").
          to_return(status: 404)

        WebMock.stub(:delete, "http://localhost/genie/v2/jobs/123").
          to_return(body: @@job)

        options = Client::KillOptions.new(id: "123", progress: true)

        client = Client.new(@@config)
        jobs = client.kill(options)

        jobs.size.should eq(1)
        jobs.first.progress.should eq(0)
      end
    end

    describe "search" do
      it "can search a job" do
        WebMock.stub(:get, "http://localhost/genie/v2/jobs?limit=32&name=blah").
          to_return(body: @@jobs)

        options = Client::SearchOptions.new("blah", limit: 32, progress: false)

        client = Client.new(@@config)
        jobs = client.search(options)

        jobs.should eq(Array(Model::Job).from_json(@@jobs))
      end

      it "can parse job logs to get job progress" do
        WebMock.stub(:get, "http://localhost/genie-jobs/123/stderr.log").
          to_return(body: "line\nblah\n1%\nblah\n100%")

        WebMock.stub(:get, "http://localhost/genie/v2/jobs?limit=32&name=blah").
          to_return(body: @@jobs)

        options = Client::SearchOptions.new("blah", progress: true, limit: 32)

        client = Client.new(@@config)
        jobs = client.search(options)

        jobs.size.should eq(1)
        jobs.first.progress.should eq(100)
      end

      it "be ok if stderr not found" do
        WebMock.stub(:get, "http://localhost/genie-jobs/123/stderr.log").
          to_return(status: 404)

        WebMock.stub(:get, "http://localhost/genie/v2/jobs?limit=32&name=blah").
          to_return(body: @@jobs)

        options = Client::SearchOptions.new("blah", progress: true, limit: 32)

        client = Client.new(@@config)
        jobs = client.search(options)

        jobs.size.should eq(1)
        jobs.first.progress.should eq(0)
      end
    end
  end
end
