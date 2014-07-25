# coding: utf-8

names = ["Anon user", "foobar", "hogehoge"]
i = 0
names.each do |name|
  Comment.create(
    name: name,
    body: "Test comment #{i}",
    article_id: 4,
  )
  i += 1
end

Comment.create(
  name: "Other",
  body: "Test comment for other article",
  article_id: 3,
)
