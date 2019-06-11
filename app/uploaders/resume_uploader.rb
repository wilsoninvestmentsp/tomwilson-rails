# encoding: utf-8

class ResumeUploader < CarrierWave::Uploader::Base

  storage :file

  def filename
    "#{model.first_name}-#{model.last_name}.#{file.extension}" if original_filename.present?
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
end
