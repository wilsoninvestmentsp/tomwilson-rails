class HomeController < ApplicationController
  def index
    @testimonies = Testimony.all
    @properties_featured_one_to_three = Property.active.not_sold.by_featured(FEATURED_PROPERTIES_ROW_1_POSITIONS).order(:featured)
    @properties_featured_four_to_six  = Property.active.not_sold.by_featured(FEATURED_PROPERTIES_ROW_2_POSITIONS).order(:featured)
    @all_properties = Property.active.not_sold.by_featured([1,2,3,4,5,6]).order(:featured).map { |property| PropertySerializer.new(property, root: false) }
  end
end

FEATURED_PROPERTIES_ROW_1_POSITIONS = [1,2,3]
FEATURED_PROPERTIES_ROW_2_POSITIONS = [4,5,6]