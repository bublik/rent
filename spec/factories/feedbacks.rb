# == Schema Information
#
# Table name: feedbacks
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  message    :text
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :feedback do
    references ""
    message "MyText"
  end
end
