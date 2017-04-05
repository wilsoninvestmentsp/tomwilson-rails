module EventsHelper
  def event_time(event_t, utc_offset)
    time_zone = utc_offset < 0 ? '-%H:%M' : '+%H:%M'
    utc_offset = (utc_offset.abs.to_s.first(5).to_i) 
    hours = Time.zone.at(utc_offset).strftime(time_zone)
    time = DateTime.strptime(event_t.to_s, '%Q').new_offset(hours)
    time.strftime('%B %d, %Y %l:%M %p')
  end
end