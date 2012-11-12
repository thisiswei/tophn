class PagesController < ApplicationController

  def index
    @links = Link.all.sort_by{|l| l.votes.count}.reverse
    @user = current_user
  end
end
