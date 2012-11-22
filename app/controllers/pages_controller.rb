class PagesController < ApplicationController
  respond_to :json, :html, :xml
  def index
    @links = Link.order('created_at DESC').page(params[:page]).per_page(Link::PER_PAGE)
    @last_link_time = Link.last.updated_at
    respond_with @links
  end
end
