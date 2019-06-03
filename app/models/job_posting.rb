class JobPosting < ActiveRecord::Base
  enum job_status: { inactive: 0, active: 1 }
end
