class SessionsController < ApplicationController
  before_action :check_login, only: [:index]

  def index
  end

  def create
    if params[:email].empty? && params[:password].empty?
      flash[:danger] = "Email and Password can't be blank"
      return render 'index'
    end

    user = User.find_by_email params[:email]

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      rurl = root_url
      rurl = CGI.unescape params[:redirect_uri] if params[:redirect_uri].present?
      redirect_to rurl, flash: {success: "Welcome #{user.name}!"}
    else
      flash[:danger] = "Email or password is invalid."
      render 'index'
      flash.delete :danger
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path, flash: {warning: "Logged out!"}
  end

  private

  def check_login
    redirect_to root_url if current_user
  end
end