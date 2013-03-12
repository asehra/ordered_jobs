class SelfDependenceError < StandardError; end

class JobSequencer
  def self.sequence(specs)
    sequence = JobSequencer.new
    specs.lines.each { |spec| sequence.add spec }
    sequence.list
  end

  def initialize
    @job_list = []
  end

  def add(spec)
    job_names = spec.split('=>').map(&:strip)
    if !job_names[1] || job_names[1].length == 0
      add_job(job_names[0]) unless has_job?(job_names[0])
    else
      add_dependency(job_names[0], job_names[1])
    end
  end

  def add_job(name)
    @job_list << Job.new(name)
  end

  def index job_name
    @job_list.index {|j| j.name == job_name }
  end

  def has_job? job_name
    index job_name
  end

  def add_dependency(name, dependency)
    raise SelfDependenceError.new if name == dependency
    if has_job?(dependency)
      @job_list.insert(index(dependency)+1, Job.new(name))
    else
      if has_job? name
        @job_list.insert(index(name), Job.new(dependency))
      else
        add_job dependency
        add_job name
      end
    end
  end

  def list
    @job_list
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

  def to_s
    name
  end
end
