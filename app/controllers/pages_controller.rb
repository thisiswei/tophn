class PagesController < ApplicationController
  def index
    @links = Link.paginate(:page => params[:page], :per_page => 30)
  end
end
