module EventsHelper
  def event_time(event_t)
    time = DateTime.strptime(event_t.to_s, '%Q').new_offset('-0700')
    time.strftime('%B %d, %Y %l:%M %p')
  end
end