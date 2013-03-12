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
    JobSequencer.sequence("a => \nb => \nc =>").should have_sequence_with_jobs(["a", "b", "c"])
  end

  it "should return sequence with c before b when b depends on c in job structure" do
    JobSequencer.sequence("a => \nb => c\nc =>").should have_sequence_with_jobs(["a", "c", "b"])
    JobSequencer.sequence("a => \nb => c\nc =>").should place("c").before("b")
  end

  it "should return sequence with correct order for a complicated job structure" do
    JobSequencer.sequence("a => \nb => c\nc => f\nd => a\ne => b\nf =>").should have_sequence_with_jobs(["a", "b", "c", "d", "e", "f"])

    JobSequencer.sequence("a => \nb => c\nc => f\nd => a\ne => b\nf =>").should place("c").before("b")
    JobSequencer.sequence("a => \nb => c\nc => f\nd => a\ne => b\nf =>").should place("f").before("c")
    JobSequencer.sequence("a => \nb => c\nc => f\nd => a\ne => b\nf =>").should place("a").before("d")
    JobSequencer.sequence("a => \nb => c\nc => f\nd => a\ne => b\nf =>").should place("b").before("e")
  end

  it "should raise error when a job depends on itself" do
    lambda{ JobSequencer.sequence("a => \nb => \nc => c") }.should raise_error(SelfDependenceError)
  end
end