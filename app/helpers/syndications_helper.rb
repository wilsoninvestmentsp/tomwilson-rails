module SyndicationsHelper
  def quarterly_price(quarter)
    quarter.present? ? raw_price(quarter) : '-' 
  end

  def track_record_status_color(status)
    case status
      when 'sold'
        'red'
      when 'currently_held'
        'yellow'
      when 'active'
       'green' 
    end
  end
end