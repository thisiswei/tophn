class LinksController < ApplicationController
  REG = /[a-zA-Z0-9]+(\.[a-zA-Z]+)+/
  def index

  end
  def show
  end

  def new
    @link = Link.new
  end


end
