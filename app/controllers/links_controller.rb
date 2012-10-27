class LinksController < ApplicationController
  def index

  end
  def show
  end

  def new
    @link = Link.new
  end

  def create
    @link = Link.create(params[:link])
    redirect_to pages_url
  end
end
