class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  process resize_to_limit: [500, 500]
  storage :file
  version :thumb do
    process resize_to_fill: [100, 100]
  end
  
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
end
