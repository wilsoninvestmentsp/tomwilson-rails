class ImagesController < ApplicationController
  def index
    @images = Image.all
    render json: @images
  end

  def create
    if params[:file].present?
      file = params.require(:file)
      @image = Image.new property_id: params[:property_id],image: file
      if @image.save
        render json: @image,status: :created
      else
        render json: {errors: @user.errors},status: :unprocessable_entity
      end
    end

    if params[:url].present?
      url = params.require(:url)
      @image = Image.new property_id: params[:property_id],remote_image_url: url
      if @image.save
        render json: @image,status: :created
      else
        render json: {errors: @user.errors},status: :unprocessable_entity
      end
    end
  end

  def destroy
    @image = Image.find(params[:id])
    if @image.destroy
      render json: nil,status: :ok
    else
      render json: nil,status: :unprocessable_entity
    end
  end
	{"public_id"=>"ijieuihof31oj5ejbv5t", "version"=>1467759446, "signature"=>"bbe7731597c5062bdc543f6f3769249c5083fbf6", "width"=>960, "height"=>720, "format"=>"jpg", "resource_type"=>"image", "created_at"=>"2016-07-05T22:57:26Z", "tags"=>[], "bytes"=>181168, "type"=>"upload", "etag"=>"75df14731c97f6a94bb3140f8ebbf3fa", "url"=>"http://res.cloudinary.com/wambl/image/upload/v1467759446/ijieuihof31oj5ejbv5t.jpg", "secure_url"=>"https://res.cloudinary.com/wambl/image/upload/v1467759446/ijieuihof31oj5ejbv5t.jpg", "original_filename"=>"1-front-view-McKinley-Ave.2962"}
end