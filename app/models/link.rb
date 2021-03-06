# == Schema Information
#
# Table name: links
#
#  id         :integer          not null, primary key
#  url        :string(255)
#  title      :string(255)
#  rate       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  clip       :string(255)
#  detail     :text(65535)
#  appeal     :boolean          default(FALSE)
#  link_type  :string(255)      default("daily")
#

# -*- encoding : utf-8 -*-
class Link < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged
  # attr_accessible :title, :body
  has_many :photos
  
  scope :recent, -> { order(:title => :desc)}

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

  def self.best_of_all
    order("rate desc").limit(10)
  end

  def self.best_of_the_month
    where("created_at between ? and ? and rate > 2", Date.today.beginning_of_month, Date.today.end_of_month).order("rate DESC").limit(5)
  end

  def self.best_of_the_week
    where("created_at between ? and ? and rate > 1", Date.today.beginning_of_week, Date.today.end_of_week).order("rate DESC").limit(5)
  end

  def self.worst_of_all
    where("rate < 0").order("rate asc").limit(10)
  end

  def self.appeal
    where("appeal = true").order("rate asc")  
  end

  def calculate_rate
    self.rate = self.get_likes.size - self.get_dislikes.size
    self.save
  end

  def up_vote_by_this_user(voter)
    if voter.voted_on?(self)
      return false
    else
      self.liked_by(voter)
      self.calculate_rate
      return true
    end 
  end

  def down_vote_by_this_user(voter)
    if voter.voted_on?(self)
      return false
    else
      self.disliked_by(voter)
      self.calculate_rate
      return true
    end 
  end

end
