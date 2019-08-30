module EventsHelper
  def event_time(event_t, utc_offset)
    time_zone = utc_offset < 0 ? '-%H:%M' : '+%H:%M'
    utc_offset = (utc_offset.abs.to_s.first(5).to_i)
    hours = Time.zone.at(utc_offset).strftime(time_zone)
    time = DateTime.strptime(event_t.to_s, '%Q').new_offset(hours)
    time.strftime('%B %d, %Y %l:%M %p')
  end

  def event_address(event_venue)
    "/api/v1/map.png?address=#{event_venue['address_1']},#{event_venue['city']},#{event_venue['state']}&width=600&height=300"
  end

  def meetup_token_expired?
    meetup_api_token = ApiToken.find_by(platform: 'meetup')
    return true if meetup_api_token.nil?
    meetup_api_token.expire_on < Time.now
  end

  def meetup_auth_url
    "#{Settings.meetup.authorize_end_point}?client_id=#{MEETUP_API_KEY}&response_type=code&redirect_uri=#{OAUTH_REDIRECT_URL}&scope=ageless+event_management"
  end
end