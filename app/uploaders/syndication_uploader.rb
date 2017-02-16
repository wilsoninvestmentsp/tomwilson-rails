class SyndicationUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave
  version :thumb do
    process resize_to_fill: [768,427]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def default_url
    '/custom/no-image.png'
  end
end