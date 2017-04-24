class SyndicationsController < ApplicationController
  before_action :authorize, except: [:index,:show]
  before_action :set_syndication, only: [:show, :edit, :update, :destroy]

  def index
    @syndications = Syndication.by_user(current_user).page(params[:page]).per(Settings.pagination.syndication.per_page)
  end

  def new
    @syndication = Syndication.new
    @syndication.annual_returns.build
  end

  def create
    close_date = Date.strptime(params[:syndication][:close_date], '%m/%d/%Y').to_date if params[:syndication][:close_date].present?
    @syndication = Syndication.new(syndication_params.merge!(close_date: close_date))
    if @syndication.save
      redirect_to syndications_path, flash: {success: "#{@syndication.title} was successfully created!"}
    else
      render :new
    end
  end

  def show
    @syndication_years = @syndication.annual_returns.pluck(:year).uniq.sort.reverse
    @annual_return = @syndication.annual_returns.by_latest_year
    @annual_return = @syndication.annual_returns.by_year(params[:year]) if params[:year].present?
  end

  def edit
  end

  def update
    close_date = Date.strptime(params[:syndication][:close_date], '%m/%d/%Y').to_date if params[:syndication][:close_date].present?
    if @syndication.update(syndication_params.merge!(close_date: close_date))
      redirect_to syndications_path, flash: {success: "#{@syndication.title} was successfully updated!"}
    else
      render :edit
    end
  end

  def destroy
    @syndication.destroy
    redirect_to syndications_path, flash: {danger: "#{@syndication.title} was successfully deleted."}
  end

  private

  def set_syndication
    @syndication = Syndication.where(slug: params[:id]).first
    redirect_to syndications_path, flash: {danger: "Track Record '#{params[:id]}' not found"} if @syndication.nil?
  end

  def syndication_params
    params.require(:syndication).permit(:title, :status, :purchase_price, :raise_amount, :hold_period,
    :preferred_return, :average_annual_return, :irr, :price_per_share, :loan_amount,
    :loan_rate, :year_built, :building_size, :lot_size, :number_of_buildings, :property_type, :number_of_tenants,
    :image, :notes, :location, :active, annual_returns_attributes: [:year, :projected_annual_return, :actual_annual_return,
    :quarter_1, :quarter_2, :quarter_3, :quarter_4, :id, :_destroy])
  end
end