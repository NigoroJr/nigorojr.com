class TopController < ApplicationController
  def about
    @foo = `date`
  end

  def index
    @date = `date`
  end
end
