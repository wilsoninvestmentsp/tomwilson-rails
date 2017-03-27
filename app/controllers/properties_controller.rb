class PropertiesController < ApplicationController
  before_action :authorize,except: [:index,:show,:get_cities]
  before_action :set_property, only: [:show, :edit, :update, :destroy]
  before_action :set_status_options
  before_action :detect_device, only: [:index]

  def index
    @properties = Property.active
    if params[:building_type].present?
      building_types = params[:building_type].split(',')
      building_types = building_types.count > 1 ? building_types : params[:building_type]
      @properties = @properties.by_building_type(building_types)
    end
    pagination_by_device
    @properties = @properties.order_by_status.page(params[:page]).per(@per_page)
  end

  def pagination_by_device
    if @browser.device.tablet?
      per_page = Settings.pagination.properties.per_page.tablet
    elsif @browser.device.mobile?
      per_page = Settings.pagination.properties.per_page.mobile
    else
      per_page = Settings.pagination.properties.per_page.default
    end
    @per_page = per_page
  end

  def show
  end

  def new
    @property = Property.new
    @images = []
  end

  def edit
  end

  def create
    @property = Property.new(property_params.merge!({active: true}))
    respond_to do |format|
      if @property.save
        format.html { redirect_to @property, flash: {success: "#{@property.raw_title} was successfully created!"} }
        format.json { render :show, status: :created, location: @property }
      else
        format.html { render :new }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @property.update(property_params)
        format.html { redirect_to @property, flash: {success: "#{@property.raw_title} was successfully updated!"} }
        format.json { render :show, status: :ok, location: @property }
      else
        format.html { render :edit }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @property.destroy
    respond_to do |format|
      format.html { redirect_to properties_url, flash: {danger: "#{@property.raw_title} was successfully deleted."} }
      format.json { head :no_content }
    end
  end

  def import
    if params[:file].present?
      file_extension = File.extname params[:file].original_filename
      if file_extension != '.csv'
        return redirect_to import_url, flash: {danger: "Please select CSV file to import properties..."}
      end
      error_csv = Property.import params[:file]
      if error_csv.nil?
        redirect_to import_url, flash: {success: "Properties has been imported successfully..."}
      else
        send_data error_csv, filename: "errors_#{Time.now.to_i}.csv"
      end
    else
      redirect_to import_url, flash: {danger: "Please select CSV file to import properties..."}
    end
  end

  private

  def set_property
    @property = Property.where(slug: params[:id], active: true).first
    redirect_to properties_path, flash: {danger: "Property '#{params[:id]}' not found"} if @property.nil?
  end

  def detect_device
    user_agent = request.user_agent
    @browser = Browser.new(user_agent, accept_language: "en-us")
  end

  def set_status_options
    @building_types = [
      ['All','single_family,duplex,fourplex,multifamily,commercial,townhouse'],
      ['Investment Homes', 'single_family,duplex,fourplex'],
      ['Multifamily','multifamily'],
      ['Commercial','commercial']
    ]

    @status_options = [
      ['Select One',nil],
      ['Coming Soon',:coming_soon],
      ['For Sale',:for_sale],
      ['Reserved',:reserved],
      ['Sale Pending',:sale_pending],
      ['Sold',:sold],
      ['Not Active',:not_active]
    ]

    @building_type_options = [
      ['Select One',nil],
      ['Single Family',:single_family],
      ['Duplex',:duplex],
      ['Fourplex',:fourplex],
      ['Multifamily',:multifamily],
      ['Commercial',:commercial]
    ]

    @leased_options = [
      ['Yes',:yes],
      ['No',:no],
      ['Partial',:partial]
    ]
  end

  def property_params
    params.require(:property).permit(
      :address,
      :year_built,
      :square_ft,
      :offer_price,
      :rent,
      :status,
      :leased,
      :bedrooms,
      :bathrooms,
      :garages,
      # :carports,
      :monthly_return,
      :images,
      :city,
      :state,
      :zip,
      :title,
      :highlight,
      :offer_price_label,
      :description,
      :featured,
      :building_type,
      :cash_flow,
      :lot_size,
      :school_district,
      :active,
      :property_management_fee,
      :mortgage_payment,
      :hoa_fee,
      :property_tax,
      :hazard_insurance,
      :image
    )
  end
end
