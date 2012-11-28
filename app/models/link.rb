class Link < ActiveRecord::Base
  # attr_accessible :title, :body
  has_one :photo

  scope :recent, order("title DESC", :limit => "11")
end