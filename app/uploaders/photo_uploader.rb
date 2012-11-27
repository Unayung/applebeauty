# encoding: utf-8

class PhotoUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick
  include CarrierWave::Meta

  # Include RMagick or MiniMagick support:

  # include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  #storage :fog
  #storage :fog
  
  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  
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
   # "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
   "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{id_partition(model)}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
     "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:


  # process :store_meta
  
  # version :tiny do
  #    process :resize_to_fill => [50, 50]
  #    process :store_meta
  # end
  
  # version :pin do 
  #    process :resize_to_fit => [90, 120]
  #    process :store_meta
  # end
  
  # version :medium do 
  #    process :resize_to_fit => [330, 440]
  #    process :store_meta
  # end
  
  # version :large do
  #    process :resize_to_fit => [500,750]
  #    process :store_meta
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
