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
    if !@logged_in_as.can_modify(@article)
      raise Forbidden
    end
  end

  def create
    attributes = params.require(:article).permit(:title, :body, :tags, :category, :language)
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
    attributes = params.require(:article).permit(:title, :body, :tags, :category, :language)
    @article = Article.find(params[:id])
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
    if !@logged_in_as.can_modify(@article)
      raise Forbidden
    end

    @article.destroy
    redirect_to :articles, notice: "Deleted article"
  end
end
