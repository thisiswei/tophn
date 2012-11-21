class PagesController < ApplicationController
  respond_to :json, :html, :xml
  def index
    @links = Link.order('updated_at DESC').page(params[:page]).per_page(Link::PER_PAGE)
    respond_with @links
  end
end
