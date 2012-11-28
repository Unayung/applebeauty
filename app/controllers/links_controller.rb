# -*- encoding : utf-8 -*-
class LinksController < ApplicationController

  def index
    @links = Link.recent.paginate(:page => params[:page], :per_page => 18)
    #@links = @links.order(:title, :limit => "11")
  end

  def show
    @link = Link.find(params[:id])

    set_page_description("蘋果我最美 - #{@link.title}")
    set_page_keywords(@link.detail)
    if @link.photo
      set_page_image(Setting.domain + @link.photo.file.url)
    end
  end
end
