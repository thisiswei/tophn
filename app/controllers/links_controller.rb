class LinksController < ApplicationController

  def index

  end
  def show
  end

  def new
    @link = Link.new
  end

  def create
    unless current_user.nil?
      @link = current_user.links.new(params[:link])
      if Link.find_by_url(params[:link][:url]).nil? and !REGG.match(params[:link][:url]).nil?
        @link.save
        redirect_to pages_path
      else
        flash[:notice] = 'sorry...posted already'
        redirect_to new_link_path
      end
    else
      redirect_to pages_path
      flash[:notice] = 'please sign in..'
    end
  end
end