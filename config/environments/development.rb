Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Asset digests allow you to set far-future HTTP expiration dates on all assets,
  # yet still be able to expire them through the digest params.
  config.assets.digest = true

  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  config.action_mailer.delivery_method = :mailgun
  config.action_mailer.mailgun_settings = {
          api_key: ENV['MAILGUN_API_KEY'],
          domain: ENV['MAILGUN_DOMAIN']
  }

  # MailChimp
  MAIL_CHIMP_API_KEY = ENV['MAIL_CHIMP_API_KEY']
  MAIL_CHIMP_NEWSLETTER_ID = ENV['MAIL_CHIMP_NEWSLETTER_ID']

  #ZohoCRM
  ZOHO_API_KEY = ENV['ZOHO_API_KEY']

  # Zendesk
  ZENDESK_DOMAIN = ENV['ZENDESK_DOMAIN']
  ZENDESK_USER = ENV['ZENDESK_USER']
  ZENDESK_API_KEY = ENV['ZENDESK_API_KEY']
  ZENDESK_SECTION_ID = ENV['ZENDESK_SECTION_ID']

  # GOOGLE
  GOOGLE_BROWSER_KEY = ENV['GOOGLE_BROWSER_KEY']
  GOOGLE_SERVER_KEY = ENV['GOOGLE_SERVER_KEY']

  # MeetUp
  MEETUP_API_KEY = 'giaq0j5r1t78o9cugmqdancpj1'
  MEETUP_API_SECRET = 'cjjos1pbspk64j7v2qu0euap5b'
  OAUTH_REDIRECT_URL = 'https://a4bd7345.ngrok.io/oauth2/meetup_api'


  # Master Spreadsheet
  MASTER_SPREADSHEET_ID = ENV['MASTER_SPREADSHEET_ID']

  # Phone Number
  PHONE_NUMBER = ENV['PHONE_NUMBER']
  FAX_NUMBER = ENV['FAX_NUMBER']

  #Home Page Background Youtube Video
  HOMEPAGE_VIDEO_ID = ENV['HOMEPAGE_VIDEO_ID']

end