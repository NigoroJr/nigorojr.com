# coding: utf-8

titles = ["title 1", "second", "3rd title"]

titles.each do |title|
  Article.create(
    title: title,
    body: "Hi, this is a test!",
    author: "NigoroJr",
    category: "tips",
    language: "English",
  )
end

Article.create(
  title: "Testing!",
  body: "日本語の記事のテストです",
  author: "Naoki",
  category: "tips",
  language: "Japanese",
)
