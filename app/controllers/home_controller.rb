class HomeController < ApplicationController
  after_action :reset_locale, only: :index_cn
  layout 'thank_you', only: [:thank_you, :login_iframe]

  def index
    @testimonies = Testimony.order(:sort).limit(8)
    properties = Property.active.for_sale_and_reserved.limit(6)
    @properties = Property.order_featured_properties(properties)
    @meetup_event = MeetupEvent.last
    @syndications = Syndication.where(status: ['active', 'currently_held']).order(:status).by_user(current_user).limit(4)
  end

  def thank_you
  end

  def login_iframe
  end

  def index_cn
    I18n.locale = :cn
  end

  private

  def reset_locale
    I18n.locale = :en
  end
end