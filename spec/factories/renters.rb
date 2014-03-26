# == Schema Information
#
# Table name: renters
#
#  id          :integer          not null, primary key
#  phone       :string(255)
#  email       :string(255)
#  guard_time  :datetime
#  town        :string(255)
#  rooms       :integer
#  amount      :integer
#  сheck_in    :time
#  description :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :renter do
    phone "MyString"
    email "MyString"
    guard_time "2014-03-24 21:48:16"
    town "MyString"
    rooms 1
    amount 1
    сheck_in "2014-03-24 21:48:16"
    description "MyString"
  end
end