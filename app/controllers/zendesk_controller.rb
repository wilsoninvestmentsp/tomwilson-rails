class ZendeskController < ApplicationController

	before_action :set_zendesk

	def ticket

		p = params.require(:inquiry)
		ZohoNewsletter.signup(p.merge(investor_source: 'Website'))
		
		# if p[:property].present?

		# 	PropertyMailer.user_email(p).deliver_later
		# 	PropertyMailer.internal_email(p).deliver_later

		# else

		# 	PropertyMailer.contact_user(p).deliver_later
		# 	PropertyMailer.contact_internal(p).deliver_later

		# end

		render json: params,status: 200

	end

	def articles

		url = URI.escape("https://#{ZENDESK_DOMAIN}.zendesk.com/api/v2/help_center/sections/#{ZENDESK_SECTION_ID}/articles.json")
		uri = URI.parse url

		http = Net::HTTP.new uri.host,443
		http.verify_mode = OpenSSL::SSL::VERIFY_NONE
		http.use_ssl = true

		request = Net::HTTP::Get.new uri.path
		request.content_type = 'application/json'
		request.basic_auth ZENDESK_USER+'/token',ZENDESK_API_KEY

		response = http.request request

		code = response.code.to_f.round
		body = response.body

		render json: JSON.parse(body),status: code

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