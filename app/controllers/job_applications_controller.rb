class JobApplicationsController < ApplicationController
  before_action :set_job_application, only: [:show, :edit, :update, :destroy]
  before_action :set_job_list, only: :apply_job

  def index
    @job_applications = JobPosting.all
  end

  def new
    @job_application = JobApplication.new
  end

  def create
    @job_application = JobApplication.new(job_application_params)
    if @job_application.save
      ResumeMailer.resume_mail(@job_application).deliver_now
      redirect_to job_applications_path, flash: {success: "Your job application submitted successfully."}
    else
      render :new
    end
  end

  def show
  end

  def apply_job
  end

  def edit
  end

  def update
    if @job_application.update(job_application_params)
      redirect_to @job_application, flash: {success: "You are successfully applied for '#{@job_application.job_posting.name}' job application"}
    else
      render :edit
    end
  end

  private

  def set_job_application
    @job_application = JobApplication.find_by(id: params[:id])
    redirect_to job_applications_path, flash: {danger: "Job Application'#{params[:id]}' not found"} if @job_application.nil?
  end

  def set_job_list
    @job_application = JobPosting.find_by(id: params[:id])
    redirect_to job_postings_path, flash: {danger: "Job '#{params[:id]}' not found"} if @job_application.nil?
  end

  def job_application_params
    params.require(:job_application).permit(:resume, :first_name, :last_name, :email, :phone, :current_company, :linkedin_url, :job_posting_id)
  end
end
