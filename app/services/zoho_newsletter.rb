class ZohoNewsletter
  def self.signup(signup_params)
    email = signup_params[:email]
    first_name = signup_params[:first_name]
    last_name = signup_params[:last_name]
    phone = signup_params[:phone]
    investor_source = signup_params[:investor_source]
    begin
      contact = RubyZoho::Crm::Contact.new(email: email, first_name: first_name, last_name: last_name, phone: phone, potential_investor_source: investor_source)
      contact.save
    rescue => error
      Rails.logger.error "Something Went Wrong while Saving Newsletter Details for Email: #{email}, Exception: #{error}"
      false
    end
  end
end 