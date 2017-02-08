class BlogUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave
  process resize_to_fill: [1920]
  process tags: ['blog_picture']

  version :thumb do
    process resize_to_fill: [768]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def default_url
    '/custom/no-image.png'
  end
end