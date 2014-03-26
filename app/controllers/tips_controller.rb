class TipsController < ApplicationController
  def index
    @tips = Tip.order("created_at")
  end

  def search
    @tips = Tip.search(params[:q])
    render "index"
  end

  def show
    if (not params[:id].blank?)
      @tip = Tip.find(params[:id])
    end
  end

  def new
  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end
end
