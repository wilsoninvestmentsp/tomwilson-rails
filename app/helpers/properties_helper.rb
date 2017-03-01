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

  def meta_description(property)
    bedrooms =  property.bedrooms.to_i > 0 ? ", Bedroom: #{property.bedrooms.to_i}" : ''
    bathrooms = property.bathrooms.to_i > 0 ? ", Bathroom: #{property.bathrooms.to_i}" : ''
    garages = property.garages.to_i > 0 ? ", Garage: #{property.garages.to_i}" : ''
    "Buy or Lease #{property.raw_building_type} Property in #{property.city}, #{property.raw_state}. #{property.raw_title}#{bedrooms}#{bathrooms}#{garages}"
  end  
end