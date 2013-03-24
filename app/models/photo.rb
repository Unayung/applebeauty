# -*- encoding : utf-8 -*-
class Photo < ActiveRecord::Base
  # attr_accessible :title, :body
  include Rails.application.routes.url_helpers

  belongs_to :link
  mount_uploader :file , PhotoUploader

  def to_jq_upload
  {
    "name" => read_attribute(:file),
    "size" => file.size,
    "url" => file.url,
    "thumbnail_url" => file.tiny.url,
    "delete_url" => link_photo_path(link,id),
    "delete_type" => "DELETE",
  }
  end
end
