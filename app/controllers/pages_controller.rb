class PagesController < ApplicationController
  def index
    @top_links = Link.all.sort_by{|l| l.votes.count}.reverse

    @links = @top_links
    @user = current_user
    #.paginate(:page => params[:page], :per_page => 30)
  end
end
