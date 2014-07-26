class Comment < ActiveRecord::Base
  belongs_to :article, class_name: "Article", foreign_key: "article_id"

  validates :name, presence: true
  validates :body, presence: true, length: { maximum: 2000 }
end
