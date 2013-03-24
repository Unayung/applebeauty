# -*- encoding : utf-8 -*-
class Link < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :photos
  
  scope :recent, order("title DESC", :limit => "11")

  acts_as_votable

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

  def self.best_of_the_month
    where("created_at between ? and ? and rate > 5", Date.today.beginning_of_month, Date.today.end_of_month).order("rate DESC").limit(5)
  end

  def self.best_of_the_week
    where("created_at between ? and ? and rate > 5", Date.today.beginning_of_week, Date.today.end_of_week).order("rate DESC").limit(5)
  end

  def self.worst_of_all
    where("rate < 0").order("rate asc").limit(5)
  end
end
