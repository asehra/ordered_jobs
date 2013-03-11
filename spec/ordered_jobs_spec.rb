require "spec_helper"
require "matchers"

require_relative "../lib/ordered_jobs.rb"

describe "ordered jobs" do
  it "should return empty sequence for an empty description" do
    JobSequencer.sequence("").should eql([]) 
  end

  it "should return sequence with single job for job description with one job" do
    JobSequencer.sequence("a =>").should have_sequence_with_jobs(["a"])
  end
end