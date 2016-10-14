class JassetsController < ApplicationController

  before_action :authorize, except: [:index]
  before_action :set_jasset, only: [:show, :edit, :update, :destroy]

  # GET /jassets
  # GET /jassets.json
  def index
    @jassets = Jasset.all
  end

  # GET /jassets/1
  # GET /jassets/1.json
  def show
  end

  # GET /jassets/new
  def new
    @jasset = Jasset.new
  end

  # GET /jassets/1/edit
  def edit
  end

  # POST /jassets
  # POST /jassets.json
  def create
    @jasset = Jasset.new(jasset_params)

    respond_to do |format|
      if @jasset.save
        format.html { redirect_to @jasset, flash: {success: "#{@jasset.title} was successfully created."} }
        format.json { redirect_to jassets_url, status: :created, location: @jasset }
      else
        format.html { render :new }
        format.json { render json: @jasset.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /jassets/1
  # PATCH/PUT /jassets/1.json
  def update
    respond_to do |format|
      if @jasset.update(jasset_params)
        format.html { redirect_to @jasset, flash: {success: "#{@jasset.title} was successfully updated."} }
        format.json { redirect_to jassets_url, status: :ok, location: @jasset }
      else
        format.html { render :edit }
        format.json { render json: @jasset.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jassets/1
  # DELETE /jassets/1.json
  def destroy
    @jasset.destroy
    respond_to do |format|
      format.html { redirect_to jassets_url, flash: {success: "#{@jassets.title} was successfully deleted."} }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_jasset
      @jasset = Jasset.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def jasset_params
      params.require(:jasset).permit(:title, :description, :link_name, :link_uri, :sort, :image, :remote_image_url)
    end
end
