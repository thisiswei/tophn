class LinksController < ApplicationController
  def index

  end
  def show
  end

  def new
    @link = Link.new
  end

  def create
    @user = User.find_by_username(params[:username])
    @link = Link.new(params[:link])
    @link.user_id = @user.id
    @link.save
    redirect_to pages_url
  end
end
