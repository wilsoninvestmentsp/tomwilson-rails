class HomeController < ApplicationController
  def index
    @testimonies = Testimony.all
    properties = Property.active.for_sale_and_reserved.limit(6)
    @properties = Property.order_featured_properties(properties)

    title = 'Real Estate Investing - Property Investment Company, US'
    description = 'Investing in Real Estate? TomWilson is best property investment company in United State. We are specialising in residential & commercial real estate syndication.'
    prepare_meta_tags(title: title,
                      description: description,
                      twitter: {title: title, description: description},
                      og: {title: title, description: description}
                      )
  end

  def index_cn
  end
end