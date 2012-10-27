class VotesController < ApplicationController
  def index
  end

  def create
    @vote = Vote.new(params[:vote])
    @vote.user_id = current_user.id
    @vote.save
    redirect_to pages_path


  end
end
