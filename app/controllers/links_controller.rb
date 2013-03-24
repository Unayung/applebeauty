# -*- encoding : utf-8 -*-
class LinksController < ApplicationController

  before_filter :find_voter, :only => [:like, :dislike, :show]
  before_filter :search_object, :only => [:index, :show, :best_of_the_week, :best_of_the_month, :search, :worst_of_all]
  before_filter :find_link, :only => [:show, :like, :dislike]

  include ActionView::Helpers::SanitizeHelper

  def index

    if params[:q].present?
      @query_string = params[:q][:detail_cont]
      @links = @search.result.recent.paginate(:per_page => 18, :page => params[:page])
    else
      @links = Link.recent.paginate(:per_page => 18, :page => params[:page])
    end
  end

  def show

    @link.rate = @link.likes.size - @link.dislikes.size
    @link.save

    set_page_title("#{@link.title}")
    set_page_description(strip_tags("#{@link.detail}"))
    set_page_keywords(@link.detail)

    if @link.photos
      set_page_image(Setting.domain + @link.photos.first.file.url)
    end

    @next = @link.next
    @previous = @link.previous
  end

  def like
    if @voter.voted_on?(@link)
      flash[:notice] = "您投過票囉"
    else
      @voter.likes(@link)
      @link.rate = @link.likes.size - @link.dislikes.size
      @link.save
      flash[:notice] = "感謝您神聖一票，已列入統計"
    end
  end

  def dislike
    if @voter.voted_on?(@link)
      flash[:notice] = "您投過票囉"
    else
      @voter.dislikes(@link)
      @link.rate = @link.likes.size - @link.dislikes.size
      @link.save
      flash[:notice] = "感謝您神聖一票，已列入統計"
    end
  end

  def best_of_the_week
    set_page_title("本週最優")
    @links = Link.best_of_the_week
    if @links.empty?
      get_random_link
    end
  end

  def best_of_the_month
    set_page_title("本月最優")
    @links = Link.best_of_the_month

    if @links.empty?
      get_random_link
    end
  end

  def worst_of_all
    set_page_title("賣鬧專區")
    @links = Link.worst_of_all
  end

  protected

  def find_link
    @link = Link.find(params[:id])
  end

  def find_voter
    session[:voting_id] = request.remote_ip
    @voter = Session.find_or_create_by_ip(session[:voting_id])
  end

  def search_object
    @search = Link.ransack(params[:q])
  end

  def get_random_link
    offset0 = rand(Link.count)
    offset1 = rand(Link.count)
    offset2 = rand(Link.count)
    @random_links = []
    @random_links << Link.first(:offset => offset0)
    @random_links << Link.first(:offset => offset1)
    @random_links << Link.first(:offset => offset2)
  end
end
