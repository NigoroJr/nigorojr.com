# coding: utf-8

class ArticlesController < ApplicationController
  # Articles that will be shown in top controller
  CATEGORY_TOP = "top"

  before_filter :login_required, :except => [:index, :show, :search]

  def index
    # Exculde categories such as 'top#about', 'top#index', or even just 'top'
    @articles = Article.order("created_at DESC").where("category NOT LIKE ?", "#{CATEGORY_TOP}%")

    # Limit language to display (if necessary)
    if session[:language].present?
      @articles = Article.search_by_language(@articles, session[:language])
    end
  end

  def search
    @articles = Article.order("created_at DESC")

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
    attributes = params.require(:article).permit(:title, :body, :tags, :category, :language, :is_draft)
    @article = Article.new(attributes)

    # Automatically set username of logged in user
    @article.posted_by = @logged_in_as.username

    # Convert language to standard form
    @article.language = normalize_language(@article.language)

    if @article.save
      if @article.is_draft
        flash[:notice] = "Saved article as draft"
        redirect_to :action => "index"
      else
        flash[:notice] = "Posted article"
        redirect_to @article
      end
    else
      render "new"
    end
  end

  def update
    attributes = params.require(:article).permit(:title, :body, :tags, :category, :language, :is_draft)
    @article = Article.find(params[:id])

    # Previously saved as a draft
    was_draft = @article.is_draft

    @article.assign_attributes(attributes)

    # Automatically set username of logged in user
    @article.posted_by = @logged_in_as.username

    # Convert language to standard form
    @article.language = normalize_language(@article.language)

    # If editing a draft, update the `created_at` also
    if was_draft
      @article.created_at = Time.now
    end

    if @article.save
      if @article.is_draft
        flash[:notice] = "Saved article as draft"
        redirect_to :action => "index"
      else
        flash[:notice] = "Updated article"
        redirect_to @article
      end
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
    flash[:notice] = "Deleted article"
    redirect_to :articles
  end

  private
  # Given a string that represents a language, this method returns the
  # standard string (in this application) that represents that language.
  # For example, given "日本語", this method returns "Japanese".
  # Got these languages from Wikipedia.
  def normalize_language(language)
    case language
    when "日本語"
      return "Japanese"
    when "Español"
      return "Spanish"
    when "Русский"
      return "Russian"
    when "Français"
      return "French"
    when "中文"
      return "Chinese"
    when "Italiano"
      return "Italian"
    # If none matches
    else
      return language
    end
  end
end
