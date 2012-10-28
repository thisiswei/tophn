class VotesController < ApplicationController
  def index
  end

  def create
    @links = Link.paginate(:page => params[:page], :per_page => 30)
    @vote = current_user.votes.create(params[:vote])
    respond_to do |format|
        format.html{redirect_to pages_path}
        format.js
      end
    end
end
