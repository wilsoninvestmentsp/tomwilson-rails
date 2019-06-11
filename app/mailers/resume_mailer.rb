class ResumeMailer < ApplicationMailer
  def resume_mail job_application
    @job_application = job_application
    attachments[@job_application.resume.file.filename.to_s] = @job_application.resume.read
    mail from: "#{@job_application[:first_name]} #{@job_application[:last_name]} <#{@job_application[:email]}>",to: 'jennifer@wilsoninvest.com', subject: @job_application.job_posting.name
  end
end
