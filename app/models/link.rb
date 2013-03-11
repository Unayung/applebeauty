# -*- encoding : utf-8 -*-
class Link < ActiveRecord::Base
  # attr_accessible :title, :body
  has_one :photo

  scope :recent, order("title DESC", :limit => "11")

  def previous
    query = Link.recent
    index = query.find_index(self)
    prev_id = query[index-1] || query.last
    return query.find(prev_id)
  end

  def next
    query = Link.recent
    index = query.find_index(self)
    next_id = query[index+1] || query.first
    return query.find(next_id)
  end
end
