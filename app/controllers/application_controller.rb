class ApplicationController < ActionController::Base
  #force_ssl if: :ssl_required?

    # require '/LIBS/gentools' if Rails.env.development?

    # Prevent CSRF attacks by raising an exception.
  	# For APIs, you may want to use :null_session instead.
  	protect_from_forgery with: :exception if !Rails.env.development?

  	after_filter :set_csrf_cookie_for_ng

    http_basic_authenticate_with name: STAGING_USERNAME,password: STAGING_PASSWORD if Rails.env.test?

  	def set_csrf_cookie_for_ng
  	  cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  	end

    # ERROR PAGES
    # :-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:
    # :-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:
    def page_not_found
      respond_to do |format|
        format.html { render template: 'errors/404', layout: 'layouts/error', status: 404 }
        format.all  { render nothing: true, status: 404 }
      end
    end
    def change_rejected
      respond_to do |format|
        format.html { render template: 'errors/422', layout: 'layouts/error', status: 422 }
        format.all  { render nothing: true, status: 422 }
      end
    end
    def server_error
      respond_to do |format|
        format.html { render template: 'errors/500', layout: 'layouts/error', status: 500 }
        format.all  { render nothing: true, status: 500 }
      end
    end
    # :-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:
    # :-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:-:

    private

    def ssl_required?
      request.host == 'wilsoninvest.com'
    end

    def use_turbolinks?

      !(controller_name == 'properties' && ['edit','new'].include?(action_name))

    end
    helper_method :use_turbolinks?

    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
    helper_method :current_user

    def authorize
      redirect_to sessions_url, flash: {danger: 'Not Authorized!'} if current_user.nil?
    end

    def icon name
      "<span class=\"glyphicon glyphicon-#{name}\"></span>".html_safe
    end
    helper_method :icon

  	protected

  	# In Rails 4.2 and above
  	def verified_request?
  	  super || valid_authenticity_token?(session, request.headers['X-XSRF-TOKEN'])
  	end

end