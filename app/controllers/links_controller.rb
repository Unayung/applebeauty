class LinksController < ApplicationController

  def index
    @links = Link.paginate(:page => params[:page], :per_page => 18)
  end
end
