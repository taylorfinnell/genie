require "../../spec_helper"

module Genie
  describe Cli::TablePrinter do
    it "can print no jobs" do
      jobs = [] of Genie::Model::Job

      printer = Genie::Cli::TablePrinter.new

      printer.io = IO::Memory.new
      printer.print(jobs, [] of String, false)

      expected = <<-PRINTED
      +----+------+--------+----------+---------+---------+----------+
      | id | name | status | progress | cluster | started | finished |
      +----+------+--------+----------+---------+---------+----------+
      +----+------+--------+----------+---------+---------+----------+

      PRINTED

      printer.string.should eq(expected)
    end

    it "prints jobs" do
      jobs = [
        Genie::Model::Job.from_json(JOB_FIXTURE.to_json),
      ]

      printer = Genie::Cli::TablePrinter.new
      printer.io = IO::Memory.new

      with_timezone("America/New_York") do
        printer.print(jobs, [] of String, false)
      end

      expected = <<-PRINTED
      +-----+------+---------+----------+------------+---------------------+---------------------+
      | id  | name | status  | progress | cluster    | started             | finished            |
      +-----+------+---------+----------+------------+---------------------+---------------------+
      | 123 | blah | RUNNING | N/A      | cluster-id | 2017-05-01 15:56:53 | 2017-05-02 15:56:53 |
      +-----+------+---------+----------+------------+---------------------+---------------------+

      PRINTED

      printer.string.should eq(expected)
    end

    it "can have headers specified" do
      jobs = [
        Genie::Model::Job.from_json(JOB_FIXTURE.to_json),
      ]

      printer = Genie::Cli::TablePrinter.new

      printer.io = IO::Memory.new
      printer.print(jobs, ["id"] of String, false)

      expected = <<-PRINTED
      +-----+
      | id  |
      +-----+
      | 123 |
      +-----+

      PRINTED

      printer.string.should eq(expected)
    end

    it "can have no header" do
      jobs = [
        Genie::Model::Job.from_json(JOB_FIXTURE.to_json),
      ]

      printer = Genie::Cli::TablePrinter.new

      printer.io = IO::Memory.new
      printer.print(jobs, ["id"] of String, true)

      expected = <<-PRINTED
      +-----+
      | 123 |
      +-----+

      PRINTED

      printer.string.should eq(expected)
    end
  end
end
