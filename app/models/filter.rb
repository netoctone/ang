class Filter < ActiveRecord::Base
  attr_accessible :job_types, :schools, :status, :tags, :name

  def job_types=(value)
    value && write_attribute(:job_types, value.to_json)
  end

  def schools=(value)
    value && write_attribute(:schools, value.to_json)
  end

  def as_json(options)
    {
      name: name,
      status: status,
      tags: tags,
      job_types: job_types && JSON.parse(job_types),
      schools: schools && JSON.parse(schools)
    }
  end
end
