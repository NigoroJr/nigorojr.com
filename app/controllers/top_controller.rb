class TopController < ApplicationController
  def index
    @articles = Article.where("category = ?", "#{ArticlesController::CATEGORY_TOP}#index")

    # Show in english if no language is specified.
    # This also applies for "all" languages.
    if session[:language].present?
      @articles = Article.search_by_language(@articles, session[:language])
    else
      @articles = Article.search_by_language(@articles, "English")
    end
  end

  def about
    @title = "About"
    @articles = Article.where("category = ?", "#{ArticlesController::CATEGORY_TOP}#about")

    # Show in english if no language is specified.
    # This also applies for "all" languages.
    if session[:language].present?
      @articles = Article.search_by_language(@articles, session[:language])
    else
      @articles = Article.search_by_language(@articles, "English")
    end
  end
end
