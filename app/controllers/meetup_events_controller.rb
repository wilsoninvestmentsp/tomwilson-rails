class MeetupEventsController < ApplicationController
  before_action :check_user
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    @meetup_event = MeetupEvent.first
    redirect_to new_meetup_event_url unless @meetup_event.present?
  end

  def new
    @meetup_event = MeetupEvent.new
  end

  def create
    @meetup_event = MeetupEvent.new(meetup_event_params)
    respond_to do |format|
      if @meetup_event.save
        format.html { redirect_to meetup_events_url, flash: {success: "#{@meetup_event.title} was successfully created."} }
        format.json { render :show, status: :created, location: @meetup_event }
      else
        format.html { render :new }
        format.json { render json: @meetup_event.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @meetup_event.update(meetup_event_params)
        format.html { redirect_to meetup_events_url, flash: {success: "#{@meetup_event.title} was successfully updated."} }
        format.json { render :show, status: :ok, location: @meetup_event }
      else
        format.html { render :edit }
        format.json { render json: @meetup_event.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
  end

  def destroy
  end

  private

  def set_event
    @meetup_event = MeetupEvent.find(params[:id])
  end

  def check_user
    redirect_to root_url unless current_user.present? && current_user.admin
  end

  def meetup_event_params
    params.require(:meetup_event).permit(:title, :description, :status, :meetup_image, :url)
  end
end
