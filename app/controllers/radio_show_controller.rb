class RadioShowController < ApplicationController

	before_action :authorize,except: [:index]
	before_action :set_directory

	def index

		@content = Content.find_by_key :radio_show_summary
		@content = Content.new key: :radio_show_summary,body: 'Blank text' if !@content

		url = URI.escape('https://www.googleapis.com/youtube/v3/search?order=date&maxResults=20&type=video&channelId=UCGSnSdEw-gG88-3E6Be0Bgw&part=snippet&key=AIzaSyDcLxfFw3-Fc99r-_GrMm0PQP2peQ1mUx0')
		uri = URI.parse url

		http = Net::HTTP.new(uri.host,443)
		http.verify_mode = OpenSSL::SSL::VERIFY_NONE
		http.use_ssl = true

		request = Net::HTTP::Get.new(uri.path+"?"+uri.query)
		request.content_type = 'application/json'

		response = http.request request

		code = response.code.to_f.round
		body = response.body

		if code == 200

			@videos = JSON.parse(body)['items']

		else

			@videos = []

		end

	end

	def update

		@content = Content.find_by_key :radio_show_summary
		@content = Content.new key: :radio_show_summary if !@content

		@content.body = params.require :content

		if @content.save

			redirect_to radio_show_path,flash: {success: 'Summary was successfully updated!'}

		else

			redirect_to radio_show_path,flash: {danger: 'An error occured.'}

		end

	end

	private
	def set_directory
		@directory = Rails.root.join('lib','radio_show_summary.html')
	end

end