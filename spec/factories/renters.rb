# == Schema Information
#
# Table name: renters
#
#  id             :integer          not null, primary key
#  phone          :string(255)
#  email          :string(255)
#  guard_time     :datetime
#  town           :string(255)
#  rooms          :string(255)
#  amount_from    :integer
#  check_in       :datetime
#  description    :text
#  created_at     :datetime
#  updated_at     :datetime
#  user_id        :integer          default(1), not null
#  orders_count   :integer          default(0), not null
#  check_out      :datetime
#  amount_to      :integer
#  state          :string(255)
#  published_at   :datetime
#  people         :integer
#  has_emailed    :boolean          default(FALSE), not null
#  phone_format   :string(255)      default("timer")
#  town_id        :integer
#  max_sales      :integer
#  agent          :boolean          default(FALSE)
#  town_area      :string(255)
#  show_check_in  :boolean          default(TRUE), not null
#  show_check_out :boolean          default(TRUE), not null
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
