class ArticlesController < ApplicationController
  attr_accessor :content, :posted_by
  before_filter :login_required, :except => [:index, :show]

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
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])

    # Don't allow editing someone else's post
    if @article.posted_by != @logged_in_as.username && @logged_in_as != UsersController::ROOT
      raise Forbidden
    end
  end

  def create
    attributes = params.require(:article).permit(:title, :body, :tags, :category, :language, :posted_by)
    @article = Article.new(attributes)

    # Automatically set username of logged in user
    @article.posted_by = @logged_in_as.username

    if @article.save
      redirect_to @article, notice: "Posted article"
    else
      render "new"
    end
  end

  def update
    @article = Article.find(params[:id])
    attributes = params.require(:article).permit(:title, :body, :tags, :category, :language, :posted_by)
    @article.assign_attributes(attributes)

    # Automatically set username of logged in user
    @article.posted_by = @logged_in_as.username

    if @article.save
      redirect_to @article, notice: "Updated article"
    else
      render "new"
    end
  end

  def destroy
    @article = Article.find(params[:id])

    # Don't delete someone else's post
    if @article.posted_by != @logged_in_as.username && @logged_in_as.username != UsersController::ROOT
      raise Forbidden
    end

    @article.destroy
    redirect_to :articles, notice: "Deleted article"
  end
end
