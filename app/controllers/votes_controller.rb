class VotesController < ApplicationController
  def index
  end

  def create
    @vote = current_user.votes.create(params[:vote])
    redirect_to pages_path


  end
end
