# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts 'ROLES'

User::ROLES.each do |role|
  Role.find_or_create_by_name(role)
  puts 'role: ' << role

  puts 'DEFAULT USER'
  user = User.find_or_create_by_email name: role,
                                      email: "#{role}@clubweb.com.ua",
                                      password: "#{role}password",
                                      password_confirmation: "#{role}password"
  puts "user: #{role} | email: #{role}@clubweb.com.ua |  password: #{role}password"
  user.add_role role
  user.confirm!
end
manager = User.find_by_name('manager')
20.times do |i|
  FactoryGirl.create(:renter, user: manager)
end
