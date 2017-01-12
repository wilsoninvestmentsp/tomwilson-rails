module PropertiesHelper

  def status_label_class(property)
    case property.status
    when 'for_sale'
      status_class = "label-green"
    when 'sold'
      status_class = "label-red"
    when 'sale_pending'
      status_class = "label-orange"
    when 'comming_soon'
      status_class = "label-skyblue"
    when 'reserved'
      status_class = "label-yellow"
    else
      status_class = "label-green"
    end
    status_class
  end
end
