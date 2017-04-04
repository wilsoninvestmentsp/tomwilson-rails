class EventsController < ApplicationController
  before_action :set_params, only: [:index, :more_events]

  def index
    get_events(@params)
  end

  def more_events
    if params[:offset].present?
      get_events(@params.merge(offset: params[:offset]))
    end
  end

  def get_events(params)
    @meetup_api = MeetupApi.new
    events = @meetup_api.events(params)
    @events = events['results']
    if events['meta']['next'].present?
      url = events['meta']['next']
      uri = URI.parse(url)
      url_params = CGI.parse(uri.query)
      @next_page = url_params['offset'].first      
    end
  end

  private

  def set_params
    @params = {
      group_urlname: Settings.meetup.group_urlname,
      scroll: 'future_or_past',
      status: 'upcoming,past', 
      format: 'json', 
      page: Settings.meetup.per_page,
      desc: true,
      limited_events: true
    }
  end
end