class AssetUploader < CarrierWave::Uploader::Base

  include Cloudinary::CarrierWave
  process :resize_to_fill => [600, 600]
  version :thumb do
    process :resize_to_fill => [100,100]
  end
  def extension_white_list
    %w(jpg jpeg gif png)
  end

end