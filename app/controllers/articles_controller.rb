class ArticlesController < ApplicationController
  #before_action :set_zendesk

  # def index
  # end
  def show
    @article = @zendesk.GetArticle params[:id]
  end

  def financing_investments
    title = 'Advice on Financing Investment in Property by various ways'
    description = 'Wilson Investment Properties has experts to help you determine what source is the best to get income after financing in property investment.'
    prepare_meta_tags(title: title, description: description,
                      twitter: {title: title, description: description},
                      og: {title: title, description: description}
                      )
  end

  def our_difference
    title = 'Our Difference - A Strategies for Success in Investment Properties'
    description = 'We use our decades of experience to maximize your return while selecting high quality properties in strong cities. We follow best strategies for success.'
    prepare_meta_tags(title: title, description: description,
                      twitter: {title: title, description: description},
                      og: {title: title, description: description}
                     )
  end

  def faq
    title = 'Real Estate Investing FAQs for Buyers, Sellers and Investors'
    description =  'By our frequently asked questions (FAQs) about real estate investing we help to get success in property investment for buyers, sellers and investors.'
    image = '/assets/bg-header-small-house.jpg'
    prepare_meta_tags(title: title, description: description, image: image,
                      twitter: {title: title, description: description, image: image},
                      og: {title: title, description: description, image: image}
                      )
  end

  def property_management
    title = 'Best Property Management Services Comapny in United State'
    description =  'Get full property management services by purchasing investment property from Wilson Investment Properties Inc. Our Managers are ready any time to help you.'
    image = '/assets/bg-header-corporate.jpg'
    prepare_meta_tags(title: title, description: description, image: image,
                      twitter: {title: title, description: description, image: image},
                      og: {title: title, description: description, image: image}
                      )
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