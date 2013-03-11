require "spec_helper"

require_relative "../lib/ordered_jobs.rb"

describe "ordered jobs" do
  it "should return empty sequence for an empty description" do
    JobSequencer.sequence("").should eql([]) 
  end
end