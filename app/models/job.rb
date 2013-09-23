class Job < ActiveRecord::Base
  attr_accessible :destination, :job_type, :operator, :pick, :school, :status, :status_changed_at
end
