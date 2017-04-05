# -*- encoding : utf-8 -*-

class PhotoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  
  def id_partition(attachment)
    case id = attachment.id
    when Integer
      ("%09d" % id).scan(/\d{3}/).join("/")
    when String
      id.scan(/.{3}/).first(3).join("/")
    else
      nil
    end
  end
    
  def store_dir
   "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{id_partition(model)}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
     "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  end
  
  version :tiny do
    process :resize_to_fill => [135, 215]
    process :store_meta
  end

end
