# == Schema Information
#
# Table name: renters
#
#  id           :integer          not null, primary key
#  phone        :string(255)
#  email        :string(255)
#  guard_time   :datetime
#  town         :string(255)
#  rooms        :integer
#  amount       :integer
#  сheck_in     :datetime
#  description  :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#  user_id      :integer          default(1), not null
#  orders_count :integer          default(0), not null
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :renter do
    phone "809305070663"
    sequence(:email) { |n| "email#{n}@renter.com" }
    guard_time { DateTime.tomorrow }
    sequence(:town) { |n|  "#{n}-MyString"}
    sequence(:rooms)
    sequence(:amount)
    check_in { DateTime.tomorrow }
    description "Description"
  end
end
