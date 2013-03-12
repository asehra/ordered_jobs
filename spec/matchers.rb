require_relative "../lib/ordered_jobs.rb"

class JobSequenceContentsMatcher
  def initialize(expected_list)
    @expected_list = expected_list.map {|j| Job.new(j)}
  end

  def matches?(actual_list)
    @actual_list = actual_list
    @missing = []
    @expected_list.each do |job|
      @missing << job unless actual_list.include? job
    end
    @missing.empty?
  end

  def failure_message
    "Sequence is missing some elements: #{ @missing }; in sequence: #{ @actual_list }"
  end
end

def have_sequence_with_jobs(expected_list)
  JobSequenceContentsMatcher.new(expected_list)
end

class OrderMatcher
  def initialize(reference)
    @reference = Job.new(reference)
  end

  def before(another)
    @another = Job.new(another)
    self
  end

  def matches?(list)
    @list = list
    @list.index(@reference) < list.index(@another)
  end

  def failure_message
    "#{ @reference } is not placed before #{ @another } in sequence #{ @list }."
  end
end

def place(reference)
  OrderMatcher.new(reference)
end
