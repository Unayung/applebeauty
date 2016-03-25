# -*- encoding : utf-8 -*-
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

class LinksController < ApplicationController

  before_filter :find_voter, :only => [:like, :dislike, :show]
  before_filter :search_object, :only => [:index, :show, :best_of_the_week, :best_of_the_month, :search, :worst_of_all, :appeal, :best_of_all]
  before_filter :find_link, :only => [:show, :like, :dislike]

  include ActionView::Helpers::SanitizeHelper

  def index

    @links = Link.all
    @links = @links.paginate(:page => params[:page], :per_page => 18)
    # if params[:q].present?
    #   @query_string = params[:q][:detail_cont]
    #   @links = @search.result.recent.paginate(:per_page => 18, :page => params[:page])
    # else
    #   @links = @search.result.recent.paginate(:per_page => 18, :page => params[:page])
    # end
  end

  def show
    @link.calculate_rate
    set_page_title("#{@link.title}")
    set_page_description(strip_tags("#{@link.detail}"))
    set_page_keywords(@link.detail)
    set_page_image(Setting.domain + @link.photos.first.file.url) if @link.photos
    get_random_link(6)
    @next = @link.next
    @previous = @link.previous
  end

  def like
    if @link.up_vote_by_this_user(@voter)
      flash[:notice] = "感謝您神聖一票，已列入統計"
    else
      flash[:notice] = "您投過票囉"
    end
  end

  def dislike
    if @link.down_vote_by_this_user(@voter)
      flash[:notice] = "感謝您神聖一票，已列入統計"
    else
      flash[:notice] = "您投過票囉"
    end
  end

  def best_of_the_week
    set_page_title("本週最優")
    @links = Link.best_of_the_week
    if @links.empty?
      get_random_link(6)
    end
  end

  def best_of_the_month
    set_page_title("本月最優")
    @links = Link.best_of_the_month

    if @links.empty?
      get_random_link(6)
    end
  end

  def worst_of_all
    set_page_title("賣鬧專區")
    @links = Link.worst_of_all
  end

  def best_of_all
    set_page_title("累計最優")
    @links = Link.best_of_all
  end

  def appeal
    set_page_title("上訴專區")
    @links = Link.appeal
    
    if @links.empty?
      get_random_link(3)
    end
  end

  protected

  def find_link
    @link = Link.find(params[:id])
  end

  def find_voter
    session[:voting_id] = request.remote_ip
    @voter = Session.find_or_create_by(:ip => session[:voting_id])
  end

  def search_object
    @search = Link.ransack(params[:q])
  end

  def get_random_link(num)
    @random_links = nil
    ids = Link.pluck(:id).shuffle[0..num-1]
    @random_links = Link.where(id: ids)
    return @random_links
  end
end
