class TopController < ApplicationController
  def index
    @articles = Article.where("category = ?", "#{ArticlesController::CATEGORY_TOP}#index")
  end

  def about
    @title = "About"
    @articles = Article.where("category = ?", "#{ArticlesController::CATEGORY_TOP}#about")
  end
end
