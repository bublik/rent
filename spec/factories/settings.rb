# == Schema Information
#
# Table name: settings
#
#  id                :integer          not null, primary key
#  autoopen          :boolean
#  autoopen_interval :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#  users             :string(255)      default("--- []\n")
#  guard_time        :integer          default(120)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :setting do
    autoopen false
    autoopen_interval "MyString"
  end
end
