class HomeController < ApplicationController
  def index
    @testimonies = Testimony.all
    @properties_featured_one_to_three = Property.active.by_featured(FEATURED_PROPERTIES_ROW_1_POSITIONS).by_status('for_sale').order(:featured)
    @properties = Property.active.by_featured(ALL_FEATURED_PROPERTIES).by_status('for_sale').order(:featured).map { |property| PropertySerializer.new(property,root: false) }

  end
end

FEATURED_PROPERTIES_ROW_1_POSITIONS = [1,2,3]
ALL_FEATURED_PROPERTIES = [1,2,3,4,5,6]