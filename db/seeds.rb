# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts 'ROLES'
  ['admin', 'manager', 'realtor', 'vip_realtor'].each do |role|
  Role.find_or_create_by_name(role)
  puts 'role: ' << role
end
puts 'DEFAULT USERS'
user = User.find_or_create_by_email name: 'Admin',
                                    email: 'rebisall@gmail.com',
                                    password: 'password',
                                    password_confirmation: 'password'
puts 'user: ' << user.name
user.add_role :admin
user.confirm!
