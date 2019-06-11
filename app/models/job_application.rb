class JobApplication < ActiveRecord::Base
  mount_uploader :resume, ResumeUploader
  belongs_to :job_posting
  validates :first_name, :last_name, :email, :phone, :current_company, presence: true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
end
