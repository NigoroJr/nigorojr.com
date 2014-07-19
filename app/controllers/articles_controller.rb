class ArticlesController < ApplicationController
  attr_accessor :content

  def index
    @articles = Article.order("created_at").reverse
  end

  def search
    @articles = Article.search(params[:q])
    render "index"
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new()
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    attributes = params.require(:article).permit(:title, :body, :tags, :category, :language, :author)
    @article = Article.new(attributes)
    # @article = Article.new(params[:article])
    if @article.save
      redirect_to @article, notice: "Posted article"
    else
      render "new"
    end
  end

  def update
    @article = Article.find(params[:id])
    attributes = params.require(:article).permit(:title, :body, :tags, :category, :language, :author)
    @article.assign_attributes(attributes)
    if @article.save
      redirect_to @article, notice: "Updated article"
    else
      render "new"
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to :articles, notice: "Deleted article"
  end
end
