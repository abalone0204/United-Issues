# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts "Generate Seed data of posts"

20.times do 
  post = Post.new(title: Faker::Name.title, 
    content: Faker::Lorem.paragraph(13),
    source: Faker::Internet.url,
    classification: Post.classification.values.sample,
    country_classification: Post.country_classification.values.sample,
    publish: true,
    complete: true,
    note: Faker::Lorem.paragraph(2),
    image: "post_2.jpg",
    source_date: DateTime.yesterday,
    publish_date: DateTime.yesterday,
    user_id: 1 )
  post.save
end

puts "Done generate seed data"