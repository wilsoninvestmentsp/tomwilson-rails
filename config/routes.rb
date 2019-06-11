Rails.application.routes.draw do

  get 'job_application/:id/apply', to: 'job_applications#apply_job', as: 'apply'
  resources :meetup_events, :job_postings, :job_applications
  resources :jassets,path: :resources
  get 'market-resources' => redirect('resources')

  get :import,to: 'jobs#index',as: :import

  get 'contact-us',to: 'contact#index',as: 'contact_us'

  # resources :articles
  resources :blogs, path: 'articles'
  get 'blog' => redirect('articles')
  get 'category/blog' => redirect('articles')
  get 'blog/*path' => redirect('articles')

  resources :syndications, path: 'track-record'

  get 'api/v1/map.png',to: 'map#index',as: 'map'
  get 'api/v1/map.js',to: 'map#js',as: 'js'
  get '/thank-you',to: 'home#thank_you',as: 'after_contact'

  # ARTICLE LINKS
  # :-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:
  # :-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:
  link = 'Our Difference'
  get link.parameterize, to: 'articles#our_difference', as: link.parameterize.underscore

  link = 'FAQ'
  get link.parameterize, to: 'articles#faq', as: link.parameterize.underscore
  get 'faqs' => redirect('faq')

  link = 'Financing Investments'
  get link.parameterize, to: 'articles#financing_investments', as: link.parameterize.underscore

  link = 'Property Management'
  get link.parameterize, to: 'articles#property_management', as: link.parameterize.underscore

  link = 'Market & City Reports'
  get link.parameterize, to: 'articles#market_and_city_reports', as: link.parameterize.underscore
  # :-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:
  # :-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:

  namespace :api do
    namespace :v1 do

      resources :links
      resources :charts
      resources :jassets

      resources :properties do

        collection do

          put :order,to: 'properties#order'

        end

      end

      resources :testimonies do

        collection do

          put :order,to: 'testimonies#order'

        end

      end

    end
  end
  get 'properties-search-results' => redirect('properties')
  get 'my-properties' => redirect('properties')
  get 'MyListings' => redirect('properties')
  get 'PropertyDetails' => redirect('properties')

  post 'api/v1/zendesk/ticket',to: 'zendesk#ticket'
  get 'api/v1/zendesk/articles',to: 'zendesk#articles'

  resources :sessions,path: 'access/normal'
  get 'access/normal',to: 'sessions#index',as: 'login'
  get 'access/logout',to: 'sessions#destroy',as: 'logout'

  resources :users,path: 'our-team'
  put 'api/v1/users/order',to: 'users#order'
  post 'api/v1/mailchimp/signup',to: 'mailchimp#signup'
  post 'api/v1/mailchimp/zendesk',to: 'mailchimp#zendesk'

  resources :events, only: :index
  get 'api/v1/meetup',to: 'events#meetup'
  get 'presentations' => redirect('events')
  get 'wipevents' => redirect('events')
  get 'Dallaspresentation' => redirect('events')
  get 'events/*path' => redirect('events')
  get 'more_events' => 'events#more_events'

  get 'angular',to: 'angular#index'

  get 'youtube',to: 'youtube#index',as: 'youtube'
  get 'youtube/:id',to: 'youtube#show'
  get 'play_video/:videoId' => 'youtube#play_video', as: 'play_video'

  get 'radio-show',to: 'radio_show#index',as: 'radio_show'
  get 'real-estate-radio-live' => redirect('radio-show')
  put 'radio-show',to: 'radio_show#update'

  resources :images
  resources :properties do

    resources :images
    collection do
      get 'get_cities'
      post :import

    end

  end

  root 'home#index'
  get 'cn', to: redirect('http://tomwilsonproperties.sfchinesemedia.com', status: 301)

  if Rails.env.production?
    get '404',to: 'application#page_not_found'
    get '422',to: 'application#change_rejected'
    get '500',to: 'application#server_error'
  end
  get '/sitemap.xml', to: redirect('http://res.cloudinary.com/wilsoninvestments/raw/upload/v1494498777/sitemap.xml', status: 301)
  get '*path' => redirect('/')
end
