class HomeController < ApplicationController
  def index
    @testimonies = Testimony.all
    properties = Property.active.for_sale_and_reserved.limit(6)
    @properties = Property.order_featured_properties(properties)
  end

  def index_cn
  end
end