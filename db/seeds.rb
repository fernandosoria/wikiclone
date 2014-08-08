require 'faker'

#Create Wikis
10.times do
  wiki = Wiki.create(
    title: Faker::Lorem.sentence,
    body: Faker::Lorem.paragraph
  )
end
wikis = Wiki.all

puts "Seed finished"
puts "#{Wiki.count} wikis created"