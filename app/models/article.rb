class Article < ActiveRecord::Base
  def Article.search(query)
    article = order("created_at")
    if article.present?
      article = article.where("tags LIKE ? OR title LIKE ?", "%#{query}%", "%#{query}%")
    end

    return article
  end
end
