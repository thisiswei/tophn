class PagesController < ApplicationController

  def index 
    Link.update(10)
    @links = Link.paginate(:page => params[:page], :per_page => 43).order('created_at DESC')
    @user  = current_user
  end
end
