# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

100.times do |n|
    rand_id = 0
    until User.find_by_id(rand_id) != nil do
        rand_id = rand(1..150)
    end
    title = "タイトル#{n+1}"
    content = "内容#{n+1}"
Blog.create!(title: title, content: content, user_id: rand_id)
end