module PropertiesHelper
  def status_label_class(property_status)
    case property_status
    when 'for_sale'
      'green'
    when 'sold'
      'red'
    when 'sale_pending'
      'orange'
    when 'comming_soon'
      'skyblue'
    when 'reserved'
      'yellow'
    else
      'green'
    end
  end

  def meta_description(property)
    bedrooms =  property.bedrooms.to_i > 0 ? ", Bedroom: #{property.bedrooms.to_i}" : ''
    bathrooms = property.bathrooms.to_i > 0 ? ", Bathroom: #{property.bathrooms.to_i}" : ''
    garages = property.garages.to_i > 0 ? ", Garage: #{property.garages.to_i}" : ''
    "Buy or Lease #{property.raw_building_type} Property in #{property.city}, #{property.raw_state}. #{property.raw_title}#{bedrooms}#{bathrooms}#{garages}"
  end
end