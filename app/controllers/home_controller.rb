class HomeController < ApplicationController
  def index
    @properties_featured_one_to_three = Property.active.not_sold.by_featured([1,2,3]).order(:featured)
    @properties_featured_four_to_six  = Property.active.not_sold.by_featured([4,5,6]).order(:featured)
    @all_properties = Property.active.not_sold.by_featured([1,2,3,4,5,6]).order(:featured).map { |property| PropertySerializer.new(property, root: false) }
  end
end
