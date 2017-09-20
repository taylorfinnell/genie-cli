require "../../spec_helper"

module Genie
  describe Cli::TabbedPrinter do
    it "can print no jobs" do
      jobs = [] of Genie::Model::Job

      printer = Genie::Cli::TabbedPrinter.new

      printer.io = IO::Memory.new
      printer.print(jobs, [] of String, false)

      expected = <<-PRINTED
      id\tname\tstatus\tprogress\tcluster\tstarted\tfinished

      PRINTED

      printer.string.should eq(expected)
    end

    it "prints jobs" do
      jobs = [
        Genie::Model::Job.from_json(JOB_FIXTURE.to_json),
      ]

      printer = Genie::Cli::TabbedPrinter.new
      printer.io = IO::Memory.new

      with_timezone("America/New_York") do
        printer.print(jobs, [] of String, false)
      end

      expected = <<-PRINTED
      id\tname\tstatus\tprogress\tcluster\tstarted\tfinished
      123\tblah\tRUNNING\tN/A\tcluster-id\t2017-05-01 15:56:53\tN/A

      PRINTED

      printer.string.should eq(expected)
    end

    it "can have headers specified" do
      jobs = [
        Genie::Model::Job.from_json(JOB_FIXTURE.to_json),
      ]

      printer = Genie::Cli::TabbedPrinter.new

      printer.io = IO::Memory.new
      printer.print(jobs, ["id"] of String, false)

      expected = <<-PRINTED
      id
      123

      PRINTED

      printer.string.should eq(expected)
    end

    it "can have no header" do
      jobs = [
        Genie::Model::Job.from_json(JOB_FIXTURE.to_json),
      ]

      printer = Genie::Cli::TabbedPrinter.new

      printer.io = IO::Memory.new
      printer.print(jobs, ["id"] of String, true)

      expected = <<-PRINTED
      123

      PRINTED

      printer.string.should eq(expected)
    end
  end
end
