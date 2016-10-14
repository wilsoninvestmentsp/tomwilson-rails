class YoutubeController < ApplicationController

	def index

		url = URI.escape("https://www.googleapis.com/youtube/v3/search?pageToken=#{params[:page]}&order=date&maxResults=#{params[:per_page] || 20}&type=video&channelId=UCGSnSdEw-gG88-3E6Be0Bgw&part=snippet&key=#{GOOGLE_SERVER_KEY}")
		uri = URI.parse url

		http = Net::HTTP.new(uri.host,443)
		http.verify_mode = OpenSSL::SSL::VERIFY_NONE
		http.use_ssl = true

		request = Net::HTTP::Get.new(uri.path+"?"+uri.query)
		request.content_type = 'application/json'

		response = http.request request

		code = response.code.to_f.round
		body = response.body

		render json: JSON.parse(body),status: code

	end

	def show

		url = URI.escape("https://www.googleapis.com/youtube/v3/videos/?key=#{GOOGLE_SERVER_KEY}&id=#{params[:id]}&part=snippet")
		uri = URI.parse url

		http = Net::HTTP.new(uri.host,443)
		http.verify_mode = OpenSSL::SSL::VERIFY_NONE
		http.use_ssl = true

		request = Net::HTTP::Get.new(uri.path+"?"+uri.query)
		request.content_type = 'application/json'

		response = http.request request

		code = response.code.to_f.round
		body = response.body

		render json: JSON.parse(body),status: code

	end

end