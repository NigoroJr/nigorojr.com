class TopController < ApplicationController
  def index
    @articles = Article.where("category = ?", "#{ArticlesController::CATEGORY_TOP}#index")
    @articles = Article.search_by_language(@articles, session[:language])
  end

  def about
    @title = "About"
    @articles = Article.where("category = ?", "#{ArticlesController::CATEGORY_TOP}#about")
    @articles = Article.search_by_language(@articles, session[:language])
  end
end
