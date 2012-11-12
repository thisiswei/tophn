class PagesController < ApplicationController

  def index
    @links = Link.paginate(:page => params[:page], :per_page => 40).order('hnscore DESC')
    @user = current_user
  end
end
