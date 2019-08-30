class EventsController < ApplicationController
  before_action :set_params, only: [:index, :more_events]

  def index
    api_token = ApiToken.find_by(platform: 'meetup')
    begin
      if api_token.present?
        if api_token.expire_on > Time.now
          events = RestClient.get "https://api.meetup.com/#{Settings.meetup.group_urlname}/events?status=upcoming,past&desc=true", headers: { "Authorization" => "Bearer #{api_token.access_token}"}
        else
          # TODO fetch new access token using refresh token
          access_response = RestClient.post Settings.meetup.OAuth_api_end_point, {client_id: MEETUP_API_KEY, client_secret: MEETUP_API_SECRET, grant_type: 'refresh_token', refresh_token: api_token.refresh_token}
        end
        events = JSON.parse(events) rescue []
        @events = Kaminari.paginate_array(events).page(params[:page]).per(Settings.pagination.blogs.per_page)
      end
      respond_to do |format|
        format.js
        format.html
      end
    rescue Exception => e
      Rails.logger.error "Error: #{e.message} - #{e.backtrace.join('\n')}"
      flash[:danger] = "Something went wrong. Please try after sometime"
      redirect_to root_path
    end
  end

  def connect_with_meetup
  end

  def more_events
    get_events(@params.merge(offset: params[:offset])) if params[:offset].present?
  end

  def get_events(params)
    @meetup_api = MeetupApi.new
    events = @meetup_api.events(params)
    events(events)
  end

  def events(events)
    if events.present? && events['meta'].present?
      if events['meta']['next'].present?
        url = events['meta']['next']
        uri = URI.parse(url)
        url_params = CGI.parse(uri.query)
        @next_page = url_params['offset'].first
      end
      @events = events['results']
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