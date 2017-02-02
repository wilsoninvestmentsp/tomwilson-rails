class ArticlesController < ApplicationController
  #before_action :set_zendesk

  # def index
  # end

  def show
    @article = @zendesk.GetArticle params[:id]
  end

  def financing_investments
  end

  def our_difference
  end

  def faq
  end

  def property_management
  end

  def market_and_city_reports
  end

  private

  def set_zendesk
    @zendesk = ZendeskApi::Connect.new(
      domain: ZENDESK_DOMAIN,
      username: ZENDESK_USER,
      token: ZENDESK_API_KEY
    )
  end

  def constraints
    params.permit :per_page
  end
end