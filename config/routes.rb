Rails.application.routes.draw do

  resources :jassets,path: :resources

  get :import,to: 'jobs#index',as: :import

  get 'contact-us',to: 'contact#index',as: 'contact_us'

  # resources :articles
  resources :blogs, path: 'articles'

  get 'api/v1/map.png',to: 'map#index',as: 'map'
  get 'api/v1/map.js',to: 'map#js',as: 'js'

  # ARTICLE LINKS
  # :-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:
  # :-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:
  link = 'Our Difference'
  get link.parameterize, to: 'articles#our_difference', as: link.parameterize.underscore

  link = 'FAQ'
  get link.parameterize, to: 'articles#faq', as: link.parameterize.underscore

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

  post 'api/v1/zendesk/ticket',to: 'zendesk#ticket'
  get 'api/v1/zendesk/articles',to: 'zendesk#articles'

  resources :sessions,path: 'access/normal'
  get 'access/normal',to: 'sessions#index',as: 'login'
  get 'access/logout',to: 'sessions#destroy',as: 'logout'

  resources :users,path: 'our-team'
  put 'api/v1/users/order',to: 'users#order'
  post 'api/v1/mailchimp/signup',to: 'mailchimp#signup'
  post 'api/v1/mailchimp/zendesk',to: 'mailchimp#zendesk'

  resources :events
  get 'api/v1/meetup',to: 'events#meetup'

  get 'angular',to: 'angular#index'

  get 'youtube',to: 'youtube#index',as: 'youtube'
  get 'youtube/:id',to: 'youtube#show'

  get 'radio-show',to: 'radio_show#index',as: 'radio_show'
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
  get 'cn' => 'home#index_cn'

  if Rails.env.production?
    get '404',to: 'application#page_not_found'
    get '422',to: 'application#change_rejected'
    get '500',to: 'application#server_error'
  end

end