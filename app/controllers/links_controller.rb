class LinksController < ApplicationController

  def index
    @links = Link.paginate(:page => params[:page], :per_page => 18)
  end

  def show
    @link = Link.find(params[:id])
  end
end
