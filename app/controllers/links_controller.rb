# -*- encoding : utf-8 -*-
class LinksController < ApplicationController

  before_filter :find_voter, :only => [:like, :dislike, :show]

  include ActionView::Helpers::SanitizeHelper

  def index

    @search = Link.ransack(params[:q])

    if params[:q].present?
      @query_string = params[:q][:detail_cont]
      @links = @search.result.paginate(:per_page => 18, :page => params[:page])
    else
      @links = Link.recent.paginate(:per_page => 18, :page => params[:page])
    end
  end

  def show
    @link = Link.find(params[:id])
    @link.rate = @link.likes.size
    @link.save

    set_page_title("#{@link.title}")
    set_page_description(strip_tags("#{@link.detail}"))
    set_page_keywords(@link.detail)
    if @link.photo
      set_page_image(Setting.domain + @link.photo.file.url)
    end

    @next = @link.next
    @previous = @link.previous
  end

  def search
    @search = Link.ransack(params[:q])

    if params[:q].present?
      @link = @search.result.paginate(:per_page => 18, :page => params[:page])
    else
      @link = Link.recent.paginate(:per_page => 18, :page => params[:page])
    end
  end

  def like
    @link = Link.find(params[:id])
    if @voter.voted_on?(@link)
      redirect_to(link_path(@link), :notice => "你投過票囉~~")
    else
      @voter.likes(@link)
      redirect_to(link_path(@link), :notice => "感謝你神聖一票，已列入統計")
    end
  end

  def dislike
    @link = Link.find(params[:id])
    if @voter.voted_on?(@link)
      redirect_to(link_path(@link), :notice => "你投過票囉~~")
    else
      @voter.dislikes(@link)
      redirect_to(link_path(@link), :notice => "感謝你神聖一票，已列入統計")
    end
  end

  def best_of_the_week
    @links = Link.best_of_the_week
  end

  def best_of_the_month
    @links = Link.best_of_the_month
  end

  protected

  def find_voter
    session[:voting_id] = request.remote_ip
    @voter = Session.find_or_create_by_ip(session[:voting_id])
  end
end
