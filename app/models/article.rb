class Article < ActiveRecord::Base
  has_many :comments, dependent: :destroy

  def self.search_by_tag(articles, tag)
    if articles.present? && tag.present?
      articles = articles.where("tags LIKE ?", "%#{tag}%")
    end

    return articles
  end

  def self.search_by_language(articles, language)
    if articles.present? && language.present?
      articles = articles.where("language LIKE ?", "%#{language}%")
    end

    return articles
  end

  def self.search_by_author(articles, screen)
    if articles.present? && screen.present?
      author = User.find_by(screen: screen)
      articles = articles.where(posted_by: author.username)
    end

    return articles
  end
end
