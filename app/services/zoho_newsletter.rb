class ZohoNewsletter
  CONTACT_METHOD = 'WIP Website'.freeze
  CONTACT_OWNER = 'rita@tomwilsonproperties.com'.freeze
  EMAIL_LISTS = 'Newsletter;Investment Opportunities'.freeze

  def self.signup(signup_params)
    email = signup_params[:email]
    first_name = signup_params[:first_name]
    last_name = signup_params[:last_name]
    phone = signup_params[:phone]
    investor_source = signup_params[:investor_source]
    contact_type = signup_params[:contact_type]
    description = signup_params[:description]
    not_include = ['Please Select Option', 'Where did you hear from us?'].freeze

    hear_from = signup_params[:hear_from] unless not_include.include?(signup_params[:hear_from])
    begin
      contact = RubyZoho::Crm::Contact.new(
        hear_from: hear_from,
        email: email,
        first_name: first_name,
        last_name: last_name,
        phone: phone,
        contact_type: contact_type,
        description: description,
        email_lists: EMAIL_LISTS,
        contact_method: CONTACT_METHOD,
        contact_owner: CONTACT_OWNER
      )
      contact.save
    rescue => error
      Rails.logger.error "Something Went Wrong while Saving Newsletter Details for Email: #{email}, Exception: #{error}"
      false
    end
  end
end