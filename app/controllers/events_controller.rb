class EventsController < ApplicationController

	def index
	end

	def meetup

		string = "https://api.meetup.com/wilson-investment-properties-inc/events?key=#{MEETUP_API_KEY}"
		string << "&page=#{params[:page]}" if params[:page].present?
		url = URI.escape(string)
		uri = URI.parse url

		http = Net::HTTP.new(uri.host,443)
		http.verify_mode = OpenSSL::SSL::VERIFY_NONE
		http.use_ssl = true

		request = Net::HTTP::Get.new(uri.path+'?'+uri.query)
		request.content_type = 'application/json'

		response = http.request request

		code = response.code.to_f.round
		body = response.body

		render json: JSON.parse(body),status: code,root: false

	end

end