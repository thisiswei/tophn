class PagesController < ApplicationController

  def index
    @links = Link.order('created_at DESC').page(params[:page]).per_page(Link::PER_PAGE)
    @user  = current_user
    Link.update(8)
  end
end
