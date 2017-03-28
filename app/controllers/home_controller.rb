class HomeController < ApplicationController
  after_action :reset_locale, only: :index_cn

  def index
    @testimonies = Testimony.order(:sort).limit(6)
    properties = Property.active.for_sale_and_reserved.limit(6)
    @properties = Property.order_featured_properties(properties)
  end

  def index_cn
    I18n.locale = :cn
  end

  private

  def reset_locale
    I18n.locale = :en
  end
end