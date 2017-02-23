class RadioShowController < ApplicationController

	before_action :authorize,except: [:index]
	before_action :set_directory

	def index
		title = 'Real Estate Radio Show on KDOW by Tom K. Wilson'
		description = 'Hear professional and latest advice on real estate markets, trends and economy by expert Real Estate Investor Tom K. Wilson on KDOW - The Business Radio Show.'
		prepare_meta_tags(title: title, description: description,
                     	twitter: {title: title, description: description},
                     	og: {title: title, description: description}
                     )

		@content = Content.find_by_key :radio_show_summary
		@content = Content.new key: :radio_show_summary,body: 'Blank text' if !@content

		url = URI.escape("https://www.googleapis.com/youtube/v3/search?order=date&maxResults=20&type=video&channelId=UCGSnSdEw-gG88-3E6Be0Bgw&part=snippet&key=#{GOOGLE_SERVER_KEY}")
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