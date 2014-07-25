class ArticlesController < ApplicationController
  before_filter :login_required, :except => [:index, :show, :search]

  def index
    @articles = Article.order("created_at")

    # Limit language to display (if necessary)
    if session[:language].present?
      @articles = Article.search_by_language(@articles, session[:language])
    end

    @articles.reverse!
  end

  def search
    @articles = Article.order("created_at")

    if params[:tag].present?
      @articles = Article.search_by_tag(@articles, params[:tag])
    end

    # If language is explicitly given OR default language is selected
    if params[:language].present? || session[:language].present?
      if params[:language] == "all"
        # When session[:language] is empty, all languages are shown
        session.delete("language")
      # Update which language to show
      elsif params[:language].present?
        session[:language] = params[:language]
      end

      @articles = Article.search_by_language(@articles, session[:language])
    end

    # Most recent post first
    @articles.reverse!

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
