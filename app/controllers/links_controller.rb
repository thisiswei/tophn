class LinksController < ApplicationController
  REG = /[a-zA-Z0-9]+(\.[a-zA-Z]+)+/
  def index

  end
  def show
  end

  def new
    @link = Link.new
  end

  def create
    if current_user
      @link = current_user.links.new(params[:link])
      unless Link.exists?(url: params[:link][:url]) and REG.match(params[:link][:url]).nil?
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
