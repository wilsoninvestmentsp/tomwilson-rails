module ApplicationHelper
  def bootstrap_class_for flash_type
    case flash_type
    when :success
      "alert-success"
    when :error
      "alert-error"
    when :alert
      "alert-block"
    when :notice
      "alert-info"
    else
      flash_type.to_s
    end
  end

  def raw_price(field)
    number_to_currency(field, precision: 0)
  end

  def validate_field(field)
    field.to_i > 0 ? true : false
  end

  def validate_price_field(field)
    field.to_i > 0 ? raw_price(field) : 'N/A'
  end

  def validate_listing_field(field)
    field.to_i > 0 ? field.to_i : 'N/A'
  end
end