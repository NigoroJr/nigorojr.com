# coding: utf-8

titles = ["title 1", "second", "3rd title"]

titles.each do |title|
  Tip.create(
    title: title,
    file_loc: title.to_s + "_location",
    author: "NigoroJr",
    category: "tips",
    language: "English",
  )
end

Tip.create(
  title: "Testing!",
  file_loc: "foo/bar/baz/file.md",
  author: "Naoki",
  category: "tips",
  language: "Japanese",
)
