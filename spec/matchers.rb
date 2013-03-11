require_relative "../lib/ordered_jobs.rb"

class JobSequenceContentsMatcher
  def initialize(expected_list)
    @expected_list = expected_list.map {|j| Job.new(j)}
  end

  def matches?(actual_list)
    @missing = []
    @expected_list.each do |job|
      @missing << job unless actual_list.include? job
    end
    @missing.empty?
  end

  def failure_message
    "Sequence is missing some elements: #{ @missing.map(&:name) }; in sequence: #{ @expected_list.map(&:name) }"
  end
end

def have_sequence_with_jobs(expected_list)
  JobSequenceContentsMatcher.new(expected_list)
end
