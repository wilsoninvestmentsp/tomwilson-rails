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

  def section_bg_class(properties, section)
    case section
      when 'magazine'
        if properties
          'grey-bg bdr-top-btm'
        else 
          'white-bg'
        end
      when 'feedback'
        if properties
          'white-bg'
        else
          'grey-bg'
        end
    end
  end
end