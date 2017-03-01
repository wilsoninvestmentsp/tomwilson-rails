require 'ruby_zoho'

RubyZoho.configure do |config|
  config.api_key = ZOHO_API_KEY
  config.crm_modules = ['Contacts']
end