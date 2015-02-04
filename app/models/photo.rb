# == Schema Information
#
# Table name: photos
#
#  id                     :integer          not null, primary key
#  file                   :string(255)
#  link_id                :integer
#  file_width             :string(255)
#  file_height            :string(255)
#  file_image_size        :string(255)
#  file_content_type      :string(255)
#  file_tiny_width        :string(255)
#  file_tiny_height       :string(255)
#  file_tiny_image_size   :string(255)
#  file_tiny_content_type :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

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
