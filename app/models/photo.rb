# -*- encoding : utf-8 -*-
class Photo < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :link
  mount_uploader :file , PhotoUploader
end
