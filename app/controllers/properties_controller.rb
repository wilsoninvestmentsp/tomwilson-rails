class PropertiesController < ApplicationController

  before_action :authorize,except: [:index,:show,:get_cities]
  before_action :set_property, only: [:show, :edit, :update, :destroy]
  before_action :set_status_options

  # GET /properties
  # GET /properties.json
  def index
    # @states ||= Property.select(:state).uniq!
    # @cities = Property.select(:city).uniq
    # min_price = Property.minimum(:offer_price)
    # max_price = Property.maximum(:offer_price)
    # @min_max_price = { min_price: min_price, max_price: max_price }
    # @sort_by_offer_price = { asc: 'Low to High', desc: 'High to Low' }
  end

  def get_cities
    @cities = Property.select(:city).where(state: params[:state]).uniq!
  end
  # GET /properties/1
  # GET /properties/1.json
  def show
  end

  # GET /properties/new
  def new
    @property = Property.new
    @images = []
  end

  # GET /properties/1/edit
  def edit
  end

  # POST /properties
  # POST /properties.json
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

  # PATCH/PUT /properties/1
  # PATCH/PUT /properties/1.json
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

  # DELETE /properties/1
  # DELETE /properties/1.json
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
      if file_extension != 'csv'
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
    # Use callbacks to share common setup or constraints between actions.
    def set_property
      @property = Property.where(slug: params[:id],active: true).first
    end

    def set_status_options
      # @status_options = [
      #   ['Select One',nil],
      #   ['For Sale',:for_sale],
      #   ['Not Active',:not_active],
      #   ['Agreement',:agreement],
      #   ['Sale Pending',:sale_pending],
      #   ['Reserved',:reserved],
      #   ['Sold',:sold]
      # ]
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

    # Never trust parameters from the scary internet, only allow the white list through.
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
