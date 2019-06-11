class JobPostingsController < ApplicationController
  before_action :authorize
  before_action :set_job, only: [:show, :edit, :update, :destroy]

  def new
    @job_posting = JobPosting.new
  end

  def index
    @job_postings = JobPosting.all
  end

  def create
    @job_posting = JobPosting.new(job_posting_params)
    if @job_posting.save
      redirect_to @job_posting, flash: {success: "'#{@job_posting.name}' was successfully created!"}
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @job_posting.update(job_posting_params)
      redirect_to @job_posting, flash: {success: "'#{@job_posting.name}' was successfully updated!"}
    else
      render :edit
    end
  end

  def destroy
    @job_posting.destroy
    redirect_to job_postings_path, flash: {danger: "'#{@job_posting.name}' was successfully deleted."}
  end

  private

  def set_job
    @job_posting = JobPosting.find_by(id: params[:id])
    redirect_to job_postings_path, flash: {danger: "Job '#{params[:id]}' not found"} if @job_posting.nil?
  end

  def job_posting_params
    params.require(:job_posting).permit(:name, :description, :city, :job_status, :job_type)
  end
end
