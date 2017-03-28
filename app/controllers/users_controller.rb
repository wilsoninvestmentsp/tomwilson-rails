class UsersController < ApplicationController

  before_action :authorize, except: [:index]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :set_options

  # GET /users
  # GET /users.json
  def index
    con = {public: true}
    con = {} if current_user
    @users = User.where(con).order(:team,:sort)
    @teams = User.all.order(:sort).group_by(&:team)
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to users_url, flash: {success: "#{@user.name} was successfully created."} }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_url, flash: {success: "#{@user.name} was successfully updated."} }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, flash: {success: "#{@user.name} was successfully deleted."} }
      format.json { head :no_content }
    end
  end

  # ORDER
  def order

    people = params.require(:users)

    order = {}
    people.each_with_index do |id,i|

      order.merge! id => {sort: i}

    end

    if User.update(order.keys,order.values)

      render json: nil,status: :ok

    else

      render json: nil,status: :unprocessable_entity

    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def set_options
      @team_options = [
        ['Select One',nil],
        ['California',:california],
        ['Texas',:texas]
      ]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :role, :phone, :image, :description, :admin, :public, :remote_image_url, :sort, :team)
    end
end