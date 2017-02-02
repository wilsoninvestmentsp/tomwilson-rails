class MailchimpController < ApplicationController
  skip_before_action :verify_authenticity_token,only: [:zendesk]

  def signup
    url = URI.escape "https://us7.api.mailchimp.com/3.0/lists/#{MAIL_CHIMP_NEWSLETTER_ID}/members"
    uri = URI(url)

    http = Net::HTTP.new(uri.host,uri.port)
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    http.use_ssl = true

    request = Net::HTTP::Post.new(uri.path)
    request.content_type = 'application/json'
    request.basic_auth 'tomwilson',MAIL_CHIMP_API_KEY
    puts "++"*30
    puts signup_params.to_json
    puts "++"*30
    request.body = signup_params.to_json
    # {
    # 	email_address": "urist.mcvankab@freddiesjokes.com",
    # 	"status": "subscribed",
    # 	"merge_fields": {
    # 		"FNAME": "Urist",
    # 		"LNAME": "McVankab"
    # 	}
    # }

    response = http.request request

    code = response.code
    body = response.body

    render json: JSON.parse(body),status: code
  end

  def zendesk
    @request = Request.new name: 'mailchimp_zendesk',status: :started,data: params[:user].to_json
    @request.save

    names = params[:user][:name].split(' ')
    first_name = names.first
    last_name = 'n/a'

    if names.count > 1
      last_name = names[1] if names[1].present?
    end

    email = params[:user][:email]
    post_data = {
      email_address: email,
      status: "subscribed",
      merge_fields: {
        "FNAME" => first_name,
        "LNAME" => last_name
      }
    }

    @request.data = post_data.to_json
    @request.status = :processed
    @request.save

    url = URI.escape "https://us7.api.mailchimp.com/3.0/lists/#{MAIL_CHIMP_NEWSLETTER_ID}/members"
    uri = URI(url)

    # curl -H "Content-Type: application/json" -X POST -d '{"user":{"name":"Tiger Woods","email":"newguy@wipadmin.com.zd"}}' http://localhost:3000/api/v1/mailchimp/zendesk.json

    http = Net::HTTP.new(uri.host,uri.port)
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    http.use_ssl = true

    request = Net::HTTP::Post.new(uri.path)
    request.content_type = 'application/json'
    request.basic_auth 'tomwilson',MAIL_CHIMP_API_KEY
    request.body = post_data.to_json

    response = http.request request

    code = response.code
    body = response.body

    @request.status = :completed
    @request.code = code.to_i
    @request.save

    render json: JSON.parse(body),status: code
  end

  private

  def signup_params
    # params.require(:signup).permit :email_address,:status,:merge_fields
    params[:signup]
  end
end