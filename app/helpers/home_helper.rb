module HomeHelper
  def status_color(status)
    case status
      when 'for_sale'
        'green'
      when 'reserved'
        'yellow'
      else
        'yellow'
    end
  end
end