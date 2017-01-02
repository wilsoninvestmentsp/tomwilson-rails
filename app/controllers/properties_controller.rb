class PropertiesController < ApplicationController
  
  before_action :authorize,except: [:index,:show]
  before_action :set_property, only: [:show, :edit, :update, :destroy]
  before_action :set_status_options

  # GET /properties
  # GET /properties.json
  def index
    # @properties = Property.where active: true
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
        format.html { redirect_to edit_property_path(@property), flash: {success: "#{@property.raw_title} was successfully updated!"} }
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
    
    csv = Property.import params[:file]

    # render json: nil
    send_data csv,filename: "errors_#{Time.now.to_i}.csv"
    # redirect_to jobs_url, flash: {warning: "Import testing."}

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
