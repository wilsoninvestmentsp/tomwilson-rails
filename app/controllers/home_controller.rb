class HomeController < ApplicationController
  def index
    @testimonies = Testimony.all
    @properties = Property.active.for_sale_and_reserved.order('created_at desc').limit(6)
    # @properties = Property.active.by_featured(ALL_FEATURED_PROPERTIES).for_sale_and_reserved.order(:featured).limit(6).map { |property| PropertySerializer.new(property,root: false) }
  end
end

# ALL_FEATURED_PROPERTIES = [1,2,3,4,5,6]