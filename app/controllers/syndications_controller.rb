class SyndicationsController < ApplicationController
  before_action :authorize, except: [:index,:show]
  before_action :set_syndication, only: [:show, :edit, :update, :destroy]

  def index
    @syndications = Syndication.all
  end

  def new
    @syndication = Syndication.new
    @syndication.annual_returns.build
  end

  def create
    @syndication = Syndication.new(syndication_params)
    if @syndication.save
      redirect_to @syndication, flash: {success: "'#{@syndication.title}' was successfully created!"}
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @syndication.update(syndication_params)
      redirect_to @syndication, flash: {success: "'#{@syndication.title}' was successfully updated!"}
    else
      render :edit
    end
  end

  def destroy
    @syndication.destroy
    redirect_to syndications_path, flash: {danger: "'#{@syndication.title}' was successfully deleted."}
  end

  private

  def set_syndication
    @syndication = Syndication.where(slug: params[:id]).first
  end

  def syndication_params
    params.require(:syndication).permit(:title, :purchase_price, :raise_amount, :hold_period,
    :preferred_return, :average_annual_return, :irr, :close_date, :price_per_share, :loan_amount,
    :loan_rate, :year_built, :building_size, :lot_size, :number_of_buildings, :property_type, :number_of_tenants,
    :image, :notes, :active, annual_returns_attributes: [:year, :projected_annual_return, :actual_annual_return,
    :quarter_1, :quarter_2, :quarter_3, :quarter_4, :id, :_destroy])
  end
end