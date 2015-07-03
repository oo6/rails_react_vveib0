# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(name: "Example", email: "email@leexu.me",
                                    password: "password",
                                    password_confirmation: "password",
                                    activated: true,
                                    activated_at: Time.zone.now)


49.times do |n|
  name = Faker::Name.name
  email = "email-#{n+1}@leexu.me"
  password = "password"
  User.create!(name: name, email: email, password: password,
                                          password_confirmation: password,
                                          activated: true,
                                          activated_at: Time.zone.now)
end

users = User.order(:created_at).take(50)
50.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.microposts.create!(content: content) }
end

# Following relationships
users = User.all
user  = users.first
following = users[2..10]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
