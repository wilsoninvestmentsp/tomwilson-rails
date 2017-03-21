class JassetsController < ApplicationController

  before_action :authorize, except: [:index]
  before_action :set_jasset, only: [:show, :edit, :update, :destroy]

  def index
    @resources = Jasset.pluck(:link_name).uniq.sort
    @order_by_resource_date = { asc: 'Oldest First', desc: 'Newest First' }
    order = params[:order_date].present? ? params[:order_date] : :desc 
    @jassets = Jasset.all.order(created_at: order)    
    @jassets = @jassets.where(link_name: params[:link_name]) if params[:link_name].present?
    @jassets = @jassets.order(created_at: params[:order_date]) if params[:order_date].present?
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
      format.html { redirect_to jassets_url, flash: {success: "#{@jasset.title} was successfully deleted."} }
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