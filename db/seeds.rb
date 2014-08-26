# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
tables = %w( articles products photos users comments skkdict_entries )
tables.each do |table|
  path = Rails.root.join("db/seeds", Rails.env, table + ".rb")
  if (File.exist?(path))
    puts "Creating #{table}"
    require path
  end
end
