class JobSequencer
  def self.sequence(description)
    job_names = description.split('=>').map(&:strip)
    jobs = job_names.map { |n| Job.new(n) }
  end

end

class Job
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def ==(other)
    self.name == other.name
  end
end
