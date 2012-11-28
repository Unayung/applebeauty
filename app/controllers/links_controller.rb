class LinksController < ApplicationController

  def index
    @links = Link.recent.paginate(:page => params[:page], :per_page => 18)
    #@links = @links.order(:title, :limit => "11")
  end

  def show
    @link = Link.find(params[:id])
  end
end
