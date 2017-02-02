class MapController < ApplicationController
  protect_from_forgery except: :js

  def index
    url = URI.escape("https://maps.google.com/maps/api/staticmap?center=#{params[:address]}&zoom=15&size=#{params[:width] || 400}x#{params[:height] || 400}&markers=color:red|#{params[:address]}&key=#{GOOGLE_SERVER_KEY}")
    uri = URI.parse url

    http = Net::HTTP.new(uri.host,uri.port)
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    http.use_ssl = true

    request = Net::HTTP::Get.new(uri.path+"?"+uri.query)
    request.content_type = 'application/binary'

    response = http.request request

    code = response.code.to_f.round
    body = response.body

    send_data response.body, type: 'image/png', disposition: 'inline'
  end

  def js
    url = URI.escape "https://maps.googleapis.com/maps/api/js?key=#{GOOGLE_BROWSER_KEY}"
    uri = URI.parse url

    http = Net::HTTP.new(uri.host,uri.port)
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    http.use_ssl = true

    request = Net::HTTP::Get.new(uri.path+"?"+uri.query)
    request.content_type = 'application/text'

    response = http.request request

    code = response.code.to_f.round
    body = response.body

    render js: response.body
  end
end