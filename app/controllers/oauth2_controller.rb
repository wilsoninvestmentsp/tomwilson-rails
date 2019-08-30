class Oauth2Controller < ApplicationController

  def meetup_api
    begin
      auth_response = RestClient.post Settings.meetup.OAuth_api_end_point, {client_id: MEETUP_API_KEY, client_secret: MEETUP_API_SECRET, grant_type: 'anonymous_code', redirect_uri: OAUTH_REDIRECT_URL, code: params[:code]}

        parsed_response = JSON.parse(auth_response)
        api_token = ApiToken.find_by(platform: 'meetup')
        if api_token.present?
          api_token.update(access_token: parsed_response['access_token'], refresh_token: parsed_response['access_token'], expire_on: Time.current + 72576000.seconds)
        else
          ApiToken.create(access_token: parsed_response['access_token'], refresh_token: parsed_response['access_token'], expire_on: Time.current + 72576000.seconds, platform: 'meetup')
        end
        flash[:success] = 'You are connected with meetup'
        redirect_to events_path
    rescue Exception => e
      Rails.logger.error "Error: #{e.message} - #{e.backtrace.join('\n')}"
      flash[:danger] = "Something went wrong. Please try after sometime."
      redirect_to root_path
    end
  end
end