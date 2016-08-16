# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



10.times do |n|
    name = Faker::Name.name
    email = "example#{n+1}@example.com"
    password = "password"
    provider = "provider#{n+1}"
User.create!(name: name, email: email, password: password, provider: provider)
end





10.times do |n|
    rand_id = 0
    while User.find_by_id(rand_id) != nil do
        rand_id = rand(1..200)
    end
    title = "タイトル#{n+1}"
    content = "内容#{n+1}"
Blog.create!(title: title, content: content, user_id: rand_id)
end