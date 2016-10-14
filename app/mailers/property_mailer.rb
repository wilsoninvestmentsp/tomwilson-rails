class PropertyMailer < ApplicationMailer

	def user_email inquiry

		@inquiry = inquiry

		mail to: @inquiry[:email],subject: @inquiry[:property][:raw_title]

	end

	def internal_email inquiry

		@inquiry = inquiry

		mail from: "#{@inquiry[:name]} <#{@inquiry[:email]}>",to: 'info@tomwilsonproperties.com',subject: @inquiry[:property][:raw_title]

	end

	def contact_internal inquiry

		@inquiry = inquiry

		mail from: "#{@inquiry[:name]} <#{@inquiry[:email]}>",to: 'info@tomwilsonproperties.com',subject: @inquiry[:subject]
		
	end

	def contact_user inquiry

		@inquiry = inquiry

		mail to: @inquiry[:email],subject: @inquiry[:subject]
		
	end

end