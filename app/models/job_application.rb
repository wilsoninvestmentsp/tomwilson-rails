class JobApplication < ActiveRecord::Base
  mount_uploader :resume, ResumeUploader
  belongs_to :job_posting
  validates :first_name, :last_name, :email, :phone, :current_company, presence: true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  # after_create :send_apply_mail

  # def send_apply_mail
  #   ResumeMailer.resume_mail(self).deliver_now
  # end
end
