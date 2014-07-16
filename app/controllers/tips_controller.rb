class TipsController < ApplicationController
  attr_accessor :content

  def index
    @tips = Tip.order("created_at").reverse
  end

  def search
    @tips = Tip.search(params[:q])
    render "index"
  end

  def show
    @tip = Tip.find(params[:id])
  end

  def new
    @tip = Tip.new()
  end

  def edit
    @tip = Tip.find(params[:id])
  end

  def create
    attributes = params.require(:tip).permit(:title, :body, :tags, :category, :language, :author)
    @tip = Tip.new(attributes)
    # @tip = Tip.new(params[:tip])
    if @tip.save
      redirect_to @tip, notice: "Posted tip"
    else
      render "new"
    end
  end

  def update
    @tip = Tip.find(params[:id])
    attributes = params.require(:tip).permit(:title, :body, :tags, :category, :language, :author)
    @tip.assign_attributes(attributes)
    if @tip.save
      redirect_to @tip, notice: "Updated tip"
    else
      render "new"
    end
  end

  def destroy
    @tip = Tip.find(params[:id])
    @tip.destroy
    redirect_to :tips, notice: "Deleted article"
  end
end
