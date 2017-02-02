class JassetsController < ApplicationController
  before_action :authorize, except: [:index]
  before_action :set_jasset, only: [:show, :edit, :update, :destroy]

  def index
    @jassets = Jasset.all
    @order_by_resource_type = { asc: 'Ascending', desc: 'Descending' }
  end

  def show
  end

  def new
    @jasset = Jasset.new
  end

  def edit
  end

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

  def destroy
    @jasset.destroy
    respond_to do |format|
      format.html { redirect_to jassets_url, flash: {success: "#{@jassets.title} was successfully deleted."} }
      format.json { head :no_content }
    end
  end

  private

  def set_jasset
    @jasset = Jasset.find(params[:id])
  end

  def jasset_params
    params.require(:jasset).permit(:title, :description, :link_name, :link_uri, :sort, :image, :remote_image_url)
  end
end