class Link < ActiveRecord::Base
  # attr_accessible :title, :body
    mount_uploader :photo , PhotoUploader
end