class LinksController < ApplicationController
  def index

  end
  def show
  end

  def new
    @link = Link.new
  end

  def create
    @link = current_user.links.create(params[:link])
    redirect_to pages_path
  end
end