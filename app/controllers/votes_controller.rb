class VotesController < ApplicationController

  def index
  end

  def create

    @links = Link.order('created_at DESC').includes(:votes).page(params[:page]).per_page(Link::PER_PAGE)
    @vote = Vote.where(:link_id => params[:vote][:link_id], :user_id => current_user.id).first

    if @vote
      @vote.up = params[:vote][:up]
      @vote.save
    else
      @vote = current_user.votes.create(params[:vote])
      respond_to do |format|
        format.html{redirect_to pages_path}
        format.js
      end
    end
  end

end
