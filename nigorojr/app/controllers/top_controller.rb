class TopController < ApplicationController
  def about
    @title = "About"
  end

  def index
    @date = `date`
  end
end
