require 'faker'

#Create Users
5.times do
  user = User.create(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: Faker::Lorem.characters(10)
  )
  user.skip_confirmation!
  user.save
end
users = User.all

#Create Wikis
10.times do
  wiki = Wiki.create(
    user: users.sample,
    title: Faker::Lorem.sentence,
    body: Faker::Lorem.paragraph
  )
end
wikis = Wiki.all

#Create an member user
member = User.create(
  name: 'Member Name',
  email: 'member@example.com',
  password: 'helloworld'
)
member.skip_confirmation!
member.save

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"