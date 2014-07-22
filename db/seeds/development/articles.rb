# coding: utf-8

titles = ["title 1", "second", "3rd title"]

titles.each do |title|
  Article.create(
    title: title,
    body: "Hi, this is a test!",
    posted_by: "naoki",
    category: "tips",
    language: "English",
  )
end

Article.create(
  title: "Testing!",
  body: "日本語の記事のテストです",
  posted_by: "test",
  category: "tips",
  language: "Japanese",
)
