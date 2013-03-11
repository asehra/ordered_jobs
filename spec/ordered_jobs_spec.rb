require "spec_helper"
require "matchers"

require_relative "../lib/ordered_jobs.rb"

describe "ordered jobs" do
  it "should return empty sequence for an empty structure" do
    JobSequencer.sequence("").should eql([]) 
  end

  it "should return sequence with single job for job structure with one job" do
    JobSequencer.sequence("a =>").should have_sequence_with_jobs(["a"])
  end

  it "should return sequence with all jobs in a job structure with multiple entries" do
    JobSequencer.sequence("a => \nb => \n c =>").should have_sequence_with_jobs(["a", "b", "c"])
  end
end