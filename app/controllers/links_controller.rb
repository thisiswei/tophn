class LinksController < ApplicationController
  def index

  end
  def show
  end

  def new
    @link = Link.new
  end

  def create
    @link = current_user.links.new(params[:link])
    if Link.find_by_url(params[:link][:url]).nil?
      @link.save
      redirect_to pages_path
    else
      flash[:notice] = 'sorry...posted already'
      redirect_to new_link_path
    end
  end
end