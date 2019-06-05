class JobPosting < ActiveRecord::Base
  enum job_status: { inactive: 0, active: 1 }
  JOB_TYPE = ['full time', 'part time']

  has_many :job_applications
  validates :name, :description, presence: true
end
