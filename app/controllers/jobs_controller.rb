class JobsController < ApplicationController
  before_action :authorize
  
  def index
    prepare_meta_tags(title: 'Import Properties - Wilson Investment Properties, Inc.')
  end

  def start
    SpreadsheetWorker.perform_async current_user.id
    redirect_to jobs_path,flash: {success: 'Sync has started!'}
  end
end