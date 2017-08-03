# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(fullname:"Adam Damn", username: "adam123", email:"adamn@gmail.com", password: "123456")


ActiveRecord::Base.transaction do
  40.times do |t|
    user = User.new
    user[:fullname] = Faker::Name.name
    user[:email] = Faker::Internet.email
    user[:username] = Faker::Name.name
    user.save
    user.update(password: "123456")
  end
end
