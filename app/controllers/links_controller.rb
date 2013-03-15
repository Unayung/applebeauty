# -*- encoding : utf-8 -*-
class LinksController < ApplicationController

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

    set_page_description("蘋果我最美 - #{@link.title}")
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
end
