class JobsController < ApplicationController
  before_action :authorize

  def index
  end

  def start
    SpreadsheetWorker.perform_async current_user.id
    redirect_to jobs_path,flash: {success: 'Sync has started!'}
  end
end